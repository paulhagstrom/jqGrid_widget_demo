class Employee < ActiveRecord::Base
  belongs_to :person
  has_many :employee_sections
  # has_many :sections, :through => :employee_sections
end
