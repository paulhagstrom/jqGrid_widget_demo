class CreateContactTypes < ActiveRecord::Migration
  def self.up
    create_table :contact_types do |t|
      t.integer :contact_type_id
      t.string :name
      t.boolean :is_private

      t.timestamps
    end
  end

  def self.down
    drop_table :contact_types
  end
end
