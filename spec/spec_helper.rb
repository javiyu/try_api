require 'factory_girl_rails'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
end

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }
FactoryGirl.definition_file_paths = ["#{Rails.root}/spec/factories"]
