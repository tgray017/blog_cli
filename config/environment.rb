require 'bundler'
Bundler.require
require 'active_record'

#database_file = '#{Dir.pwd}/database.yml'
connection_details = YAML::load(File.open("/Users/thomas.gray/flatiron/blog_cli/config/database.yml"))

ActiveRecord::Base.establish_connection(connection_details)

Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}
