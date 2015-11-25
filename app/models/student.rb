class Student < ActiveRecord::Base
  belongs_to :parent

  has_many :enrollments, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :teacher_name, presence: true
  validates :grade, presence: true

  scope :eligible, ->(min_grade, max_grade) {
    min_grade ||= 0
    max_grade ||= 5
    where('grade >= ? and grade <= ?', min_grade, max_grade)
  }

  scope :by_name, -> {
    order(:first_name)
  }

  def full_name
    "#{first_name} #{last_name}"
  end

  def friendly_grade
    grade > 0 ? grade.to_s : 'K'
  end
end
