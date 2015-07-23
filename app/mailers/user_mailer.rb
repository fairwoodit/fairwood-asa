class UserMailer < ApplicationMailer
  default from: 'fairwoodit@gmail.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to the Fairwood Activities Site')
  end
end
