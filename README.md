# pos-postgresql-migrations

Code-less Framework for doing POS (Plain-Old-SQL) PostgreSQL database schema deployments using database migration scripts. 

## Getting Started

To add new database migrations, just make a copy the migrations/0001-migration-template.sql file and rename it, incrementing the version number. Add the contents of your SQL Migration script in the file between the two "PUT YOUR MIGRATION SCRIPT HERE" comments. 

Names should be alphabetical because scripts are run in alphabetical order and scripts. Scripts are only run once, therefore you must never modify them once they have been deployed. You must only add new scripts. 

For example, future scripts might be named like this: 

    0002-some-migration-script.sql
    0003-some-other-migration-script.sql
    0004-etc-etc-script.sql

## Purpose

At Intelletive Consulting, we help organizations automate software builds and deployments. Unfortunately, we have discovered that it is very common for teams to be manually deploying their database schemas which makes it very difficult to fully automate their deployments. 

This script is meant to make it easy to setup and implement migrations in minutes for any legacy project that uses PostgreSQL. You can fork/copy these files into your own code repository and whatever CICD tool you use and in minutes have database migrations setup using nothing but plain-old-SQL. 

## Concepts

1. Migration Scripts: A list of SQL scripts to be run and applied to the database (in order). 
2. Deployment Script: A bash script that, when run, runs all of your migrations against a database. 
3. Migrations Table: A SQL Table that is used to track which migration scripts have run in order to prevent the same script from being run twice. 

## Usage with PostgreSQL CLI Client (most CICD Tools)

In a build pipeline (using whatever CICD tools you use) with the postgresql client cli installed, simply run the following command, plugging in the credentials as needed: 

    export PGUSER=postgres
    export PGPASSWORD=
    export PGHOST=localhost
    export PGPORT=5432
    export PGDATABASE=postgres
    export PSQL_SCHEMA=public
    export PSQL_EXTRA_CLI_PARAMS=
    ./run-migrations.sh

The full list of env var options is available at https://www.postgresql.org/docs/current/libpq-envars.html

## Usage with Docker

If you run these commands within the context of the official postgersql image, you can then run our script. 

To boot up postgres cli locally with docker: 

    docker run -it -w /data -v /$(PWD):/data postgres bash

And then you can run these commands like normal: 

    export PGUSER=postgres
    export PGPASSWORD=
    export PGHOST=localhost
    export PGPORT=5432
    export PGDATABASE=postgres
    export PSQL_SCHEMA=public
    export PSQL_EXTRA_CLI_PARAMS=
    ./run-migrations.sh


