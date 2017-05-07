require 'rspec/core'
require "rspec/core/rake_task"

# This Rakefile is based on the rake file used in Jeremy Evans example https://github.com/jeremyevans/roda-sequel-stack

# Migrate

migrate = lambda do |env, version|
  require_relative 'db'
  require 'logger'
  Sequel.extension :migration
  DB.loggers << Logger.new($stdout)
  Sequel::Migrator.apply(DB, 'migrate', version)
end

desc "Migrate database to latest version"
task :db_up do
  migrate.call(ENV['RACK_ENV'], nil)
end

desc "Migrate database all the way down"
task :db_down do
  migrate.call(ENV['RACK_ENV'], 0)
end

desc "Migrate database all the way down and then back up"
task :db_bounce do
  migrate.call(ENV['RACK_ENV'], 0)
  Sequel::Migrator.apply(DB, 'migrate')
end

# Shell

irb = proc do |env|
  ENV['RACK_ENV'] = env
  trap('INT', "IGNORE")
  dir, base = File.split(FileUtils::RUBY)
  cmd = if base.sub!(/\Aruby/, 'irb')
    File.join(dir, base)
  else
    "#{FileUtils::RUBY} -S irb"
  end
  sh "#{cmd} -r ./models"
end

desc "Open irb shell in test mode"
task :test_irb do 
  irb.call('test')
end

desc "Open irb shell in development mode"
task :dev_irb do 
  irb.call('development')
end

desc "Open irb shell in production mode"
task :prod_irb do 
  irb.call('production')
end

# Specs

spec = proc do |pattern|
  sh "#{FileUtils::RUBY} -e 'ARGV.each{|f| require f}' #{pattern}"
end

desc "Run all specs"
task :default => [:model_spec, :web_spec]

desc "Run model specs"
task :model_spec do
  spec.call('./spec/model/*_spec.rb')
end

desc "Run web specs"
task :web_spec do
  spec.call('./spec/web/*_spec.rb')
end

last_line = __LINE__

# specs
RSpec::Core::RakeTask.new do |t|
  ENV['RACK_ENV'] = 'test'
  t.pattern = "spec/**/*_spec.rb"
  t.ruby_opts = "-w"
end

task :default => :spec
