class Student < ActiveRecord::Base
  belongs_to :parent

  has_many :enrollments

  scope :eligible, ->(min_grade, max_grade) {
    min_grade ||= 0
    max_grade ||= 5
    where('grade >= ? and grade <= ?', min_grade, max_grade)
  }

  def full_name
    "#{first_name} #{last_name}"
  end
end
