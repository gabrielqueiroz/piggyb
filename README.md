![](https://user-images.githubusercontent.com/4305837/39401430-889229ca-4b1b-11e8-8d6a-6ff20438ef8e.png)

[![CircleCI](https://circleci.com/bb/gabrielqueiroz/piggyb.svg?style=svg&circle-token=66b2ba42a7753bf47801628448af63fdaa87778a)](https://circleci.com/bb/gabrielqueiroz/piggyb)
[![codecov](https://codecov.io/bb/gabrielqueiroz/piggyb/branch/master/graph/badge.svg?token=r55jC2x5G8)](https://codecov.io/bb/gabrielqueiroz/piggyb)

# About

PiggyB is a web application and API that helps you organize personal finance. Create piggy banks for you personal expenses, control your expenses during your trip or create piggy banks for your goals.

# Concept Idea

The idea originally came from the concept of [Piggy Banks](https://en.wikipedia.org/wiki/Piggy_bank). Present in my childhood, Piggy Banks are a way to manually save and control your money, usually used to save money for a specific goal.

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
