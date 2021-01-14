# README

## Project
Create a webapp where you can grade whiskeys that you have tried in the past.

For each whiskey you should be able to define the title, a small description and grades for tase, color, and smokiness. 

You should be able to search the entries based on title and description. Filtering on grades should be available.


## Requirements
- [x] The backend should be in Ruby on Rails.
- [x] A minimum of two models should be used with a has many relations.
- [x] Searching should be done in the backend
- [x] The frontend should be enriched with React, so react component to make the page dynamic (not a full SPA)
- [x] Tests should be written in RSpec.
- [x] Data should be stored in a RDBMS

## Dependencies
* Rails version: 6.1.0
* Ruby version: 3.0.0
* Postgres 13

## Development Setup
Run `bundle install`

As Postgres user create a `whiskeygrader` role in psql
`create role whiskeygrader with password 'password1'`
Setup development and test database with: `rails db:setup`

As Postgres user connect to development and test database with psql and install the pg_trgm extension
`CREATE EXTENSION pg_trgm;`

Run `bundle exec rspec` to run test suite

## Backlog

- [] Deployment 
- [] Filtering on grades
- [] I18n support
- [] Minimizing packs