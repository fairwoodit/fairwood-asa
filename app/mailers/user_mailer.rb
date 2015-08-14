class UserMailer < ApplicationMailer
  helper ActivitiesHelper
  helper ApplicationHelper

  default from: 'fairwoodit@gmail.com'

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Fairwood Explorer Afterschool Activities')
  end

  def enrolled_email(enrollment)
    @enrollment = enrollment
    @activity = enrollment.activity
    @user = @enrollment.student.parent
    mail(to: @user.email, subject: 'You are enrolled!')
  end

  def waiting_list_email(enrollment)
    @enrollment = enrollment
    @activity = enrollment.activity
    @user = @enrollment.student.parent
    @waiting = true
    mail(to: @user.email, subject: 'You are on the waiting list!',
         template_name: 'enrolled_email')
  end

  def low_income_enrollment_email(enrollment)
    @enrollment = enrollment
    @user = @enrollment.student.parent
    mail(to: @user.email, subject: 'Your enrollment is pending approval')
  end

  def cancel_email(enrollment)
    @enrollment = enrollment
    @activity = enrollment.activity
    @user = @enrollment.student.parent
    mail(to: ENV['ASA_EMAIL'], subject: 'Enrollment Cancellation Request')
  end

  def user_cancel_email(enrollment)
    @enrollment = enrollment
    @activity = enrollment.activity
    @user = @enrollment.student.parent
    mail(to: @user.email, subject: 'Enrollment Cancellation Request')
  end
end
