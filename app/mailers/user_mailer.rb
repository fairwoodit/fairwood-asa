class UserMailer < ApplicationMailer
  helper ActivitiesHelper
  helper ApplicationHelper

  default from: 'fairwoodit@gmail.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to the Fairwood Activities Site')
  end

  def enrolled_email(enrollment)
    @enrollment = enrollment
    @activity = enrollment.activity
    @user = @enrollment.student.parent
    mail(to: @user.email, subject: 'You are enrolled!')
  end

  def low_income_enrollment_email(enrollment)
    @enrollment = enrollment
    @user = @enrollment.student.parent
    mail(to: @user.email, subject: 'Your enrollment is pending approval')
  end
end
