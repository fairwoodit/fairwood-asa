class Enrollment < ActiveRecord::Base
  belongs_to :activity
  belongs_to :student

  before_save :fix_committed

  scope :by_activity, -> { order(:activity_id) }
  scope :lifo, -> { order(id: :desc) }
  scope :fifo, -> { order(:id) }
  scope :low_uncommitted, -> { where(low_income: true, committed: false) }

  # Rank in committed enrollments for the activity; transient field.
  attr_accessor :rank

  def fix_committed
    # Force committed to be true if we're not low income.
    self.committed = true unless low_income
  end
end
