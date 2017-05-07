# ethereum-snapshot
An api that provides a snapshot of ethereum accounts

## Build & Run
### With Docker

`docker-compose up`

Generate new Gemfile.lock:

When a new gem is added to the gemfile we need to generate a new Gemfile.lock to copy to our container

`docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app ruby:2.4.1 bundle install`

### Without Docker
Install Gems

`bundle install`

Run server

`bundle exec rackup`


## Run the tests

### With Docker

`docker-compose -f docker-compose.test.yml run web`

### Without Docker
`rake spec`

