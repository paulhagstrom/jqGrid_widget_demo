class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.integer :person_id
      t.integer :contact_type_id
      t.text :body

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
