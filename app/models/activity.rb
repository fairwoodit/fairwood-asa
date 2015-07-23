class Activity < ActiveRecord::Base
  has_many :enrollments
  has_many :students, through: :enrollments

  scope :visible, -> { where(visible: true) }
end
