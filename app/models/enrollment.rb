class Enrollment < ActiveRecord::Base
  belongs_to :activity
  belongs_to :student

  before_save :fix_committed

  scope :lifo, -> { order(id: :desc) }

  def fix_committed
    # Force committed to be true if we're not low income.
    self.committed = true unless low_income
  end
end
