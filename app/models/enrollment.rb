class Enrollment < ActiveRecord::Base
  belongs_to :activity
  belongs_to :student

  before_save :fix_committed

  scope :lifo, -> { order(id: :desc) }

  # Rank in committed enrollments for the activity; transient field.
  attr_accessor :rank

  def fix_committed
    # Force committed to be true if we're not low income.
    self.committed = true unless low_income
  end
end
