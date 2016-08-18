class UserSession < Authlogic::Session::Base
  before_create :reset_persistence_token
  logout_on_timeout true
  find_by_login_method  :find_by_activated_user

  def reset_persistence_token
    record.reset_persistence_token
  end
end
