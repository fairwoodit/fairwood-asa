class Parent < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :students
  has_many :registrations, through: :students
  before_save :update_role_if_nil

  def update_role_if_nil
    self.role = Role::NORMAL if role.blank?
  end

  def admin?
    role == Role::ADMIN
  end
end
