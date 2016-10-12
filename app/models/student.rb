require 'securerandom'

class Student < ActiveRecord::Base
  belongs_to :parent
  belongs_to :teacher

  has_many :enrollments, dependent: :destroy
  has_many :walkathon_pledges, -> {order "walkathon_pledges.id" }, class_name: 'Walkathon::Pledge', dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :grade, presence: true
  validates :full_name, uniqueness: true
  validates :uuid, uniqueness: true

  before_validation :trim_names
  before_validation :update_full_name
  before_validation :update_uuid

  scope :eligible, ->(min_grade, max_grade) {
    min_grade ||= 0
    max_grade ||= 5
    where('grade >= ? and grade <= ?', min_grade, max_grade)
  }

  scope :by_name, -> {
    order(:first_name)
  }

  def trim_names
    self.first_name.gsub(/^\s*/, '').gsub(/\s*$/, '')
    self.last_name.gsub(/^\s*/, '').gsub(/\s*$/, '')
  end

  def update_full_name
    self.full_name = "#{self.first_name} #{self.last_name}"
  end

  def update_uuid
    self.uuid = SecureRandom::uuid unless self.uuid
  end

  def friendly_grade
    grade > 0 ? grade.to_s : 'K'
  end
end
