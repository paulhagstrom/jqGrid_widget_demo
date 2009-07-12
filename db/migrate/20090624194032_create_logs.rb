class CreateLogs < ActiveRecord::Migration
  def self.up
    create_table :logs do |t|
      t.integer :person_id
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :logs
  end
end
