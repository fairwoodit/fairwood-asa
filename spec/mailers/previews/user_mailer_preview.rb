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

  def cancel_email
    UserMailer.cancel_email(Enrollment.last)
  end

  def user_cancel_email
    UserMailer.user_cancel_email(Enrollment.last)
  end

  def payment_confirmed_enrollment_email
    UserMailer.payment_confirmed_email(Enrollment.first, false)
  end

  def payment_confirmed_waiting_email
    UserMailer.payment_confirmed_email(Enrollment.last, true)
  end

  def new_pledge_email
    UserMailer.new_pledge_email(Student.last)
  end
end
