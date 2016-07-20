class Walkathon::Pledge < ActiveRecord::Base
  validates :sponsor_name, presence: true
  validates :pledge_type, presence: true
  validates :sponsor_phone, format: { with: /\d{3}-\d{3}-\d{4}/, message: 'should be in xxx-xxx-xxxx form' }, allow_blank: true
  validates :sponsor_email, format: { with: //, message: 'should be user@domain format' }, allow_blank: true
  validates_numericality_of :pledge_per_lap, :maximum_pledge, greater_than: 0, if: :per_lap?
  validates_numericality_of :fixed_pledge, greater_than: 0, if: :fixed?
  validate :has_student
  validate :has_contact_info
  validates_numericality_of :lap_count, greater_than: 0, allow_nil: true
  validates_numericality_of :paid_amount, greater_than_or_equal_to: 0, allow_nil: true

  belongs_to :student
  has_many :walkathon_payments, :class_name => 'Walkathon::Payment'

  attr_accessor :student_name

  before_save :update_committed_amount

  def per_lap?
    self.pledge_type == 'perLap'
  end

  def fixed?
    self.pledge_type == 'fixed'
  end

  def has_student
    errors.add(:student_name,
               'does not exist. Please contact fairwood-techsupport@googlegroups.com with student information.'
    ) unless student.present?
  end

  def has_contact_info
    unless sponsor_email.present? || sponsor_phone.present?
      errors.add(:sponsor_phone, 'Sponsor email address or phone number is required')
      errors.add(:sponsor_email, 'Sponsor email address or phone number is required')
    end
  end

  def update_committed_amount
    if fixed?
      self.committed_amount = self.fixed_pledge
    else
      lap_count = self.lap_count || 0
      self.committed_amount = [self.pledge_per_lap * lap_count, self.maximum_pledge].min
    end
  end

  def paid_in_full
    self.paid_amount && self.paid_amount >= self.committed_amount
  end
end
