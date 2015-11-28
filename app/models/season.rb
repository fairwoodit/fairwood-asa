class Season < ActiveRecord::Base
  validates :name, presence: true

  has_many :activities
end
