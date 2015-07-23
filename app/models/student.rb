class Student < ActiveRecord::Base
  belongs_to :parent

  has_many :enrollments

  def full_name
    "#{first_name} #{last_name}"
  end
end
