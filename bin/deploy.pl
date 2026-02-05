#!/usr/bin/env perl

use strict;
use warnings;

use lib 'lib';
use MyApp::Schema;

my $dsn    = "dbi:SQLite:dbname=contacts.db";
my $schema = MyApp::Schema->connect($dsn);

print "Deploying schema to $dsn...\n";
$schema->deploy({ add_drop_table => 1 });

print "Seeding initial data...\n";
$schema->resultset('Contact')->create({
    name  => 'Mohammad Anwar',
    email => 'manwar@cpan.org',
});

print "Done!\n";
