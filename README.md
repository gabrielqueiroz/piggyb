![](https://user-images.githubusercontent.com/4305837/39401430-889229ca-4b1b-11e8-8d6a-6ff20438ef8e.png)

[![CircleCI](https://circleci.com/bb/gabrielqueiroz/piggyb.svg?style=svg&circle-token=66b2ba42a7753bf47801628448af63fdaa87778a)](https://circleci.com/bb/gabrielqueiroz/piggyb)
[![codecov](https://codecov.io/bb/gabrielqueiroz/piggyb/branch/master/graph/badge.svg?token=r55jC2x5G8)](https://codecov.io/bb/gabrielqueiroz/piggyb)

# About

PiggyB is a web application and API that helps you organize and share your personal finance. Create piggy banks for you personal expenses and even share with a friend a common objective.

# Build and running

## Docker

- __Build Project:__ docker-compose build
- __Build Project:__ docker-compose up
- __Run database setup:__ docker-compose run --rm web rake db:setup
- __Run database migrations:__ docker-compose run --rm web rake db:migrate
