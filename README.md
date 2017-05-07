# ethereum-snapshot
An api that provides a snapshot of ethereum accounts

## Build & Run
### With Docker

`docker-compose up`

When a new gem is added to the gemfile we need to generate a new Gemfile.lock to copy to our container

`docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app ruby:2.4.1 bundle install`

### Without Docker
Install Gems

`bundle install`
<!-- TODO ADD ENV variables -->
Run server

`bundle exec rackup`


## Run the tests

### With Docker

`docker-compose -f docker-compose.test.yml run web`

### Without Docker
<!-- TODO ADD ENV variables -->
`rake spec`

