require "bundler/setup"
require 'yaml'
require "sinatra/activerecord"

require 'rspotify'

require_relative '../app/spotifycli.rb'

keys = YAML.load_file('application.yml')

RSpotify.authenticate(keys['CLIENT_ID'], keys['CLIENT_SECRET'])

Bundler.require

Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}

connection_details = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details)

ActiveRecord::Base.logger = Logger.new("db.log")


