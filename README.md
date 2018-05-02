![](https://user-images.githubusercontent.com/4305837/39401430-889229ca-4b1b-11e8-8d6a-6ff20438ef8e.png)

[![CircleCI](https://circleci.com/bb/gabrielqueiroz/piggyb.svg?style=svg&circle-token=fcf5b3e2909c0a90ad79a5b6c9cc9ec06e67409d)](https://circleci.com/bb/gabrielqueiroz/piggyb)
[![codecov](https://codecov.io/bb/gabrielqueiroz/piggyb/branch/master/graph/badge.svg?token=r55jC2x5G8)](https://codecov.io/bb/gabrielqueiroz/piggyb)

# About

PiggyB is a Web Application and API that helps you organize your personal finance.
Create Piggy Banks for you personal savings, control your expenses and reach your goals.

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

# Extra

- Piggy Bank icon found at https://icons8.com/icon/2975/money-box
