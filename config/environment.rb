require "bundler/setup"

require "sinatra/activerecord"

require 'rspotify'

require_relative '../app/spotifycli.rb'

RSpotify.authenticate("86cd2d897e5941c6969368faab903d9c", "82d553a0e5e54199877af2ce01baa902")

Bundler.require

Dir[File.join(File.dirname(__FILE__), "../app/models", "*.rb")].each {|f| require f}

connection_details = YAML::load(File.open('config/database.yml'))
ActiveRecord::Base.establish_connection(connection_details)

