class UpdatePaymentInfoInEnrollment < ActiveRecord::Migration
  def change
    remove_column :enrollments, :paid
    add_column :enrollments, :payment_type, :string, default: 'none', nullable: false
  end
end
