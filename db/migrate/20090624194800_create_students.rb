class CreateStudents < ActiveRecord::Migration
  def self.up
    create_table :students do |t|
      t.integer :person_id
      t.integer :program_id
      t.integer :status_id
      t.integer :graduating
      t.boolean :graduated
      t.string :other_degrees

      t.timestamps
    end
  end

  def self.down
    drop_table :students
  end
end
