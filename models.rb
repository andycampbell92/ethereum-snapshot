# Based on https://github.com/jeremyevans/roda-sequel-stack/blob/master/models.rb
require_relative 'db'

if ENV['RACK_ENV'] == 'development'
  Sequel::Model.cache_associations = false
end

# Validate before db insert 
Sequel::Model.plugin :auto_validations
# Improves efficiency by using prepared statements where possible
Sequel::Model.plugin :prepared_statements
# Keep track of subclasses (Our models) 
Sequel::Model.plugin :subclasses unless ENV['RACK_ENV'] == 'development'

unless defined?(Unreloader)
  require 'rack/unreloader'
  Unreloader = Rack::Unreloader.new(:reload=>false)
end

# Load our models
Unreloader.require('models'){|f| Sequel::Model.send(:camelize, File.basename(f).sub(/\.rb\z/, ''))}

if ENV['RACK_ENV'] == 'development'
  require 'logger'
  DB.loggers << Logger.new($stdout)
else
  # Freeze our models as we will not be adding more in Production/Test
  Sequel::Model.freeze_descendents
  DB.freeze
end