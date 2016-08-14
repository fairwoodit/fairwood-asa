class Parent < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :phone_number, format: { with: /\A\d{3}-\d{3}-\d{4}\Z/,
                                     message: 'must be of the form xxx-xxx-xxxx' }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :terms_of_service, acceptance: {message: 'Terms of Service must be accepted to proceed.'}, on: :create

  has_many :students, dependent: :destroy
  has_many :enrollments, through: :students
  before_save :update_role_if_nil
  after_create :send_welcome_mail

  scope :by_name, -> {
    order(:last_name, :first_name)
  }

  def update_role_if_nil
    self.role = Role::NORMAL if role.blank?
  end

  def send_welcome_mail
    UserMailer.welcome_email(self).deliver_later
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def asa?
    role && role.include?(Role::ASA) || admin?
  end

  def walkathon?
    role && role.include?(Role::WALKATHON) || admin?
  end

  def admin?
    role && role.include?(Role::ADMIN)
  end
end
