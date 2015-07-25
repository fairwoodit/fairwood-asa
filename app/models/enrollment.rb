class Enrollment < ActiveRecord::Base
  belongs_to :activity
  belongs_to :student

  before_save :fix_committed

  after_create :send_mail

  scope :lifo, -> { order(id: :desc) }

  def fix_committed
    # Force committed to be true if we're not low income.
    self.committed = true unless low_income
  end

  def send_mail
    if low_income
      UserMailer.low_income_enrollment_email(self).deliver_later
    else
      UserMailer.enrolled_email(self).deliver_later
    end
  end
end
