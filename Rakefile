require_relative './config/environment'
require_relative './db/seed'
require 'sinatra/activerecord/rake'


task :console do
  ActiveRecord::Base.logger = Logger.new(STDOUT)
  Pry.start
end

task :seed do
  Seed.seed_database
end
