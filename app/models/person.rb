class Person < ActiveRecord::Base
  has_many :students
  has_many :employees
  has_many :employee_sections, :through => :employees
  has_many :sections, :through => :employee_sections
  has_many :logs
  has_many :contacts
  has_many :degrees, :through => :students
end
