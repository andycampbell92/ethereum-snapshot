# ethereum-snapshot
An api that provides a snapshot of ethereum accounts

## Build & Run
### With Docker
Build docker image
`docker build -t ethereum-snapshot .`
Run container
`docker run -ti --rm -p 9292:9292 -v $(pwd):/usr/src/app ethereum-snapshot`

### Without Docker
Install Gems
`bundle install`
Run server
`bundle exec rackup`