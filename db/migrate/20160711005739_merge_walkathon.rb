class MergeWalkathon < ActiveRecord::Migration
  def change
    add_column :students, :full_name, :string
    add_index :students, :full_name
    add_index :students, :last_name

    create_table :walkathon_lap_counts do |t|
      t.references :student, index: {unique: true}, foreign_key: true
      t.integer :lap_count

      t.timestamps
    end

    create_table :walkathon_pledges do |t|
      t.string :sponsor_name
      t.string :sponsor_phone
      t.string :sponsor_email
      t.integer :lap_count
      t.string  :pledge_type
      t.decimal :pledge_per_lap, precision: 5, scale: 2
      t.decimal :maximum_pledge, precision: 7, scale: 2
      t.decimal :fixed_pledge, precision: 7, scale: 2
      t.decimal  :committed_amount, precision: 7, scale: 2
      t.decimal  :paid_amount, precision: 7, scale: 2
      t.references :student, index: true, foreign_key: true

      t.timestamps
    end

    create_table :walkathon_payments do |t|
      t.string :description
      t.decimal :amount, precision: 7, scale: 2
      t.references :walkathon_pledge, index: true, foreign_key: true

      t.timestamps
    end
  end
end
