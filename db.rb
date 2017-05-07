# Based on https://github.com/jeremyevans/roda-sequel-stack/blob/master/db.rb
require 'sequel'

# Delete DATABASE_URL from the environment, so it isn't accidently
# passed to subprocesses.  DATABASE_URL may contain passwords.
db_url = ENV.delete('DATABASE_URL')

if db_url.nil?
  abort("ENV['DATABASE_URL'] is not set please set this variable before continuing")
end

DB = Sequel.connect(db_url)