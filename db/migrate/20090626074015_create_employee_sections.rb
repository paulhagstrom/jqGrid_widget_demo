class CreateEmployeeSections < ActiveRecord::Migration
  def self.up
    create_table :employee_sections do |t|
      t.integer :employee_id
      t.integer :section_id
      t.boolean :is_advisor
      t.string :title

      t.timestamps
    end
  end

  def self.down
    drop_table :employee_sections
  end
end
