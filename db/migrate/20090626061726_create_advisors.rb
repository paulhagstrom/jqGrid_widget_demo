class CreateAdvisors < ActiveRecord::Migration
  def self.up
    create_table :advisors do |t|
      t.integer :student_degree_id
      t.integer :employee_id
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end

  def self.down
    drop_table :advisors
  end
end
