require "spec_helper"

require 'capybara/rspec'
require 'headless'
require 'database_cleaner'

RSpec.configure do |config|
  Capybara.javascript_driver = :selenium
  Capybara.default_wait_time = 1

  config.before :each do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  config.after do
    DatabaseCleaner.clean
  end

  headless = Headless.new
  headless.start
end