ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  module SignInHelper
    def sign_in_as(user)
      post sign_in_url(email: user.email, password: user.password)
    end
  end
end

class ActionDispatch::IntegrationTest
  include SignInHelper
end
