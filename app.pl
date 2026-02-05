#!/usr/bin/env perl

use strict;
use warnings;

use lib 'lib';

use Dancer2;
use Dancer2::Plugin::DBIC::Async;

get '/' => sub {
    template 'index';
};

post '/contacts' => sub {
    my $name  = body_parameters->get('name');
    my $email = body_parameters->get('email');

    async_create('Contact', { name => $name, email => $email }, 'default')->get;

    redirect '/contacts';
};

get '/contacts' => sub {
    my $query = query_parameters->get('q');
    my $cond  = $query ? { name => { -like => "%$query%" } } : {};

    my $search_f = async_search('Contact', $cond, 'default');
    my $count_f  = async_count('Contact', 'default');

    Future->wait_all($search_f, $count_f)->get;

    my $contacts = $search_f->get;
    my $total    = $count_f->get;

    my $html = '<ul class="list-group shadow-sm">';
    if (@$contacts) {
        foreach my $c (@$contacts) {
            $html .= sprintf(
                '<li class="list-group-item d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="my-0">%s</h6>
                        <small class="text-muted">%s</small>
                    </div>
                </li>',
                $c->{name},
                $c->{email}
            );
        }
    } else {
        $html .= '<li class="list-group-item text-muted text-center py-4">No contacts found</li>';
    }
    $html .= '</ul>';

    $html .= qq|<span id="total-count" hx-swap-oob="innerHTML">$total</span>|;

    content_type 'text/html';
    return $html;
};

dance;
