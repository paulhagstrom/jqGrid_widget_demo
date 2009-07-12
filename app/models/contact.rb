class Contact < ActiveRecord::Base
  belongs_to :contact_type
  belongs_to :person
end
