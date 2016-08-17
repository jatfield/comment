ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #fixtures :all
  require "authlogic/test_case"
  include FactoryGirl::Syntax::Methods

  def global_setup
    activate_authlogic
    @user = create(:user, name: "Titok János", password: "titok123", password_confirmation: "titok123")
    post user_sessions_url, params: { user_session: {username: @user.username, password: "titok123"}}
  end

  def file_remove
    FileUtils.rm_rf(Dir["#{Rails.root}/test/test_files/"])
  end
  # Add more helper methods to be used by all tests here...
end
