## Dancer2 application with Dancer2::Plugin::DBIC::Async and HTMX
***

#### Step 1: DEPLOY

This will create SQLite database **contacts.db**.

<br>

```bash
$ perl bin/deploy.pl
```

<br>

#### Step 2: START

<br>

```bash
$ perl app.pl
```

<br>

#### Step 3: DEMO

Go to browser and type: **http://127.0.0.1:3000/**

You should see one contact listed.

Start search contact, typing a character.

Or add contact providing name and email.
