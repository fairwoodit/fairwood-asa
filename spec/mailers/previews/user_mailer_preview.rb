# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def enrolled_email
    UserMailer.enrolled_email(Enrollment.last)
  end

  def waiting_list_email
    UserMailer.waiting_list_email(Enrollment.last)
  end

  def low_income_enrollment_email
    UserMailer.low_income_enrollment_email(Enrollment.last)
  end

  def welcome_email
    UserMailer.welcome_email(Parent.last)
  end
end
