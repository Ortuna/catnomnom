# Load the rails application
require 'net/http'
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Catnomnom::Application.initialize!
ENV['RAILS_ENV'] ||= 'production'
