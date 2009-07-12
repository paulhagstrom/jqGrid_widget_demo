class CreateEmployees < ActiveRecord::Migration
  def self.up
    create_table :employees do |t|
      t.integer :person_id
      t.text :blurb
      
      t.timestamps
    end
  end

  def self.down
    drop_table :employees
  end
end
