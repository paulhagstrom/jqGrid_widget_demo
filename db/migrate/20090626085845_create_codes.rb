class CreateCodes < ActiveRecord::Migration
  def self.up
    create_table :codes do |t|
      t.integer :student_id
      t.integer :semester_id
      t.integer :code
      t.boolean :provided

      t.timestamps
    end
  end

  def self.down
    drop_table :codes
  end
end
