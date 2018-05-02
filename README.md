![http://piggyb.herokuapp.com](https://user-images.githubusercontent.com/4305837/39401430-889229ca-4b1b-11e8-8d6a-6ff20438ef8e.png)

[![CircleCI](https://circleci.com/bb/gabrielqueiroz/piggyb.svg?style=svg&circle-token=fcf5b3e2909c0a90ad79a5b6c9cc9ec06e67409d)](https://circleci.com/bb/gabrielqueiroz/piggyb)
[![codecov](https://codecov.io/bb/gabrielqueiroz/piggyb/branch/master/graph/badge.svg?token=r55jC2x5G8)](https://codecov.io/bb/gabrielqueiroz/piggyb)

# About

PiggyB is a Web Application and API that helps you organize your personal finance.
Create Piggy Banks for you personal savings, control your expenses and reach your goals.

Check the app at http://piggyb.herokuapp.com.

# Concept Idea

The idea originally came from the concept of [Piggy Banks](https://en.wikipedia.org/wiki/Piggy_bank).
Present in my childhood, Piggy Banks are a way to manually save and control your money for a specific goal.

# Build and running

## Docker

- Build Project: `docker-compose build`
- Run database setup: `docker-compose run --rm web rake db:setup`
- Run database migrations: `docker-compose run --rm web rake db:migrate`
- Up Project: `docker-compose up`

## Local

- Install Dependencies: `bundle install`
- Setup Database: `rake db:setup`
- Run Database Migrations: `rake db:migrate`
- Start application: `rails s`

# Continuous Integration, Tests and Test Coverage

Test Coverage configured on CodeCov. Checkout the [test coverage here](https://codecov.io/bb/gabrielqueiroz/piggyb).

Continuous Integration is configured on CircleCI. Checkout the [continuous integration here](https://circleci.com/bb/gabrielqueiroz/piggyb).

## Running tests

- Running tests on dokcer: `docker-compose run --rm web bundle exec rspec`
- Running tests local: `bundle exec rspec`

# API Documentation

The project has a basic API documentation at Postman. You can find the [API documentation here](https://documenter.getpostman.com/view/4267992/RW1dFJ63#951e7a4f-f625-4bd7-8b34-5ed2cea98d86).

| Method | URL | Description |
| ------ | --- | ----------- |
| POST   | /users | Create an application user |
| POST   | /piggy_banks | Create Piggy Bank for user |
| GET    | /piggy_banks | Get all piggy banks from an user |
| PUT    | /piggy_banks/`piggy-bank-id` | Update a Piggy Bank info |
| DEL    | /piggy_banks/`piggy-bank-id` | Delete an existing piggy bank |
| GET    | /piggy_banks/`piggy-bank-id`/movements | Get all movements from a piggy bank |
| POST   | /piggy_banks/`piggy-bank-id`/movements | Make a movement for a Piggy Bank |
| DEL    | /piggy_banks/`piggy-bank-id`/movements?id=`movement_id` | Delete an existing movement for a piggy bank |

# Entity Relationship

![ER model](https://user-images.githubusercontent.com/4305837/39544752-729fa8ba-4e25-11e8-93a7-24df78b00c9a.png)

# Extra

- Piggy Bank icon found at https://icons8.com/icon/2975/money-box
