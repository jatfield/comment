class UserSession < Authlogic::Session::Base
  before_create :reset_persistence_token
  logout_on_timeout true

  def reset_persistence_token
    record.reset_persistence_token
  end
end
