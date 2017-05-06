FROM ruby:2.4.1-onbuild
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0"]