# Bowling API
This API application was made as part of Shore's hiring proccess.

In this application we can:

## Start a new game
By making a POST call to `/games` we can create a new game which will have 10 frames.

No body is required to start a new game.

## View a game information
By making a GET call to `/games/:game_id` we can check a game information.

No body is required to show a game information.

## Make a ball delivery
By making a POST call to `/games/:game_id/deliveries` we can create a new ball delivery to a game.

The amount of knocked pins can be informed with a JSON body

```json
{"knocked_pins": 10}
```

The project is also running on

https://ten-pin-bowling-api.herokuapp.com/

# What was used
- [Blueprinter](https://github.com/procore/blueprinter) to build our serializers objects.
- [CircleCI](https://circleci.com/) as the CI for this project.
- [dry-validation](https://dry-rb.org/gems/dry-validation/1.6/) to build the deliveries creation contract.
- [Factorybot](https://github.com/thoughtbot/factory_bot_rails) is used to build factories for our tests.
- [Heroku](https://heroku.com/) to deploy our project.
- [Rails](https://github.com/rails/rails) is the framework I'm most confortable working with and the one I've spent more time learning. It's powerful and really easy to start a new project.
- [Rspec](https://github.com/rspec/rspec) for testing. A powerful and versatile tool which I always use in my projects.

# What next?
This project can be improved further by
- Adding some caching to avoid excessive database access when showing a game;
- Adding a validation of how much pins you can knock each frame;

# Setting up the project

## Using Docker

**IMPORTANT** Make sure you have [Docker](https://docs.docker.com/engine/install/ubuntu/) and [Docker Compose](https://docs.docker.com/compose/install/) first.


Copy the `.env.example` into `.env`

```shell
cp .env.example .env
```

And then build the project image

```shell
docker-compose build
```

### Running the application

Run this command in your terminal

```shell
docker-compose up
```

After the boot the app will can be accessed in http://localhost:3000


### Running the tests

Run this command in your terminal

```shell
docker-compose run --rm web bundle exec rspec
```

## Local setup

**IMPORTANT** Make sure you have `ruby 2.7.2` installed.

Start by running the application's setup

```shell
bin\setup
```

This will
- Copy the `.env.example` into `.env` so you can change the values locally;
- Install the Ruby dependencies;

### Running the application

Run this command in your terminal

```shell
bin\rails server
```

After the boot the app will can be accessed in http://localhost:3000

### Running the tests

Run this command in your terminal

```shell
bundle exec rspec
```
