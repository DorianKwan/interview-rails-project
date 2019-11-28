# README

## Setup Instructions

Copy `config/database.example.yml` to `database.yml` and add your Postgres db configuration.

Install the gems:

    bundle install

Set up the database structure

    bin/rake db:reset

Run the script that will populate the database with fake data

    bin/rake db:populate

All the users have the same password: `testing`, so pick any user and log in.

