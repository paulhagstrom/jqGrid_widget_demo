class CreateDegrees < ActiveRecord::Migration
  def self.up
    create_table :degrees do |t|
      t.integer :section_id
      t.integer :program_id
      t.string :name

      t.timestamps
    end
  end

  def self.down
    drop_table :degrees
  end
end
