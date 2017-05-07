# ethereum-snapshot
An api that provides a snapshot of ethereum accounts

## Build & Run
### With Docker
Build docker image

`docker build -t ethereum-snapshot .`

Run container

`docker run -ti --rm -p 9292:9292 -v $(pwd):/usr/src/app ethereum-snapshot`

Generate new Gemfile.lock:

When a new gem is added to the gemfile we need to generate a new Gemfile.lock to copy to our container

`docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app ruby:2.4.1 bundle install`

### Without Docker
Install Gems

`bundle install`

Run server

`bundle exec rackup`


## Run the tests

`rake spec`