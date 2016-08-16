class UserMailer < ApplicationMailer

  def password_reset_mail(user_id)
 
    @user = User.find(user_id)
    @forgotten_password_url = forgotten_password_users_url(token: @user.perishable_token)
    mail(to: @user.email, subject: "Jelszóvisszaállítás a \"Szólj hozzá\" fórumhoz")
  end

end
