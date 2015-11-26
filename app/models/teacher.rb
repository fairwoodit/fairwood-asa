class Teacher < ActiveRecord::Base
  has_many :students

  validates :title, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :room, presence: true

  scope :by_name, -> {
    order(:last_name, :first_name)
  }

  def full_name
    "#{title} #{first_name} #{last_name}"
  end
end
