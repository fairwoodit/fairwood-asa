class Activity < ActiveRecord::Base
  has_many :registrations
  has_many :students, through: :registrations

  scope :visible, -> { where(visible: true) }
end
