# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def enrolled_email
    UserMailer.enrolled_email(Enrollment.last)
  end
end
