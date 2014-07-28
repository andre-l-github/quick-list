require "spec_helper"

require 'capybara/rspec'
require 'headless'

RSpec.configure do |config|
  Capybara.javascript_driver = :selenium
  Capybara.default_wait_time = 1

  headless = Headless.new
  headless.start
end