class Parent < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :students
  has_many :enrollments, through: :students
  before_save :update_role_if_nil
  after_create :send_welcome_mail

  def update_role_if_nil
    self.role = Role::NORMAL if role.blank?
  end

  def send_welcome_mail
    UserMailer.welcome_email(self).deliver_later
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    role == Role::ADMIN
  end

  def lakewood?
    school == School::LAKEWOOD
  end
end
