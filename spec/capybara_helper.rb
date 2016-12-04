require 'capybara/rspec'
require 'vcr'
require 'rails_helper'
require 'capybara/poltergeist'
require 'support/feature_helpers'
require 'capybara-screenshot/rspec'

Dir[Rails.root.join('spec/support/share_db_connection.rb')].each { |f| require f }
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.include Devise::Test::IntegrationHelpers, type: :feature

  config.include ApplicationHelper

  config.include FeatureHelpers, type: :feature

  config.before(:each, type: :feature) do
    Timecop.freeze(2016, 1, 1, 10, 5, 0)
  end

  config.after(:each, type: :feature) do
    Timecop.return
  end

  config.before(:each, js: true) do
    page.driver.browser.url_whitelist = ['http://127.0.0.1', 'https://maps.googleapis.com']
  end

  config.before(:each, type: :feature) do
    WebMock.disable_net_connect!(allow_localhost: true)
  end
end

VCR.configure do |c|
  c.ignore_localhost = true
end

Capybara.javascript_driver = :poltergeist
Capybara.default_max_wait_time = 10

options = { js_errors: false, window_size: [1600, 6000] }
Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, options)
end

# Use it instead Poltergeist for debugging views' Capybara specs

# Capybara.register_driver :chrome do |app|
#   Capybara::Selenium::Driver.new(
#     app,
#     browser: :chrome,
#     desired_capabilities: {
#       'chromeOptions' => {
#         'args' => %w{window-size=1366,768}
#       }
#     }
#   )
# end

# Capybara.javascript_driver = :chrome
