class Walkathon::Payment < ActiveRecord::Base
  belongs_to :walkathon_pledge, class_name: 'Walkathon::Pledge'
  validates :description, presence: true
  validates :amount, numericality: true

  scope :for_pledge, ->(p) {
    where('walkathon_payments.walkathon_pledge_id = ?', p).order('walkathon_payments.id')
  }

end
