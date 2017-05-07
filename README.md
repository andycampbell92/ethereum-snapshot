# ethereum-snapshot
An api that provides a snapshot of ethereum accounts

## Requirements
`Docker

Docker Compose`

## Build & Run
Start the container
`docker-compose up`

To retrieve a cached balance run

`curl http://localhost:9292/accounts/0x8eeec35015baba2890e714e052dfbe73f4b752f9`

To update a cached balance run

`curl --data '' http://localhost:9292/accounts/0x8eeec35015baba2890e714e052dfbe73f4b752f9`

When a new gem is added to the gemfile we need to generate a new Gemfile.lock to copy to our container

`docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app ruby:2.4.1 bundle install`

To rebuild our container use

`docker-compose build`

## Run the tests

`docker-compose -f docker-compose.test.yml run web`
