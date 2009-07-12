class Student < ActiveRecord::Base
  belongs_to :status
  belongs_to :person
  has_many :student_degrees
  has_many :programs
  has_many :degrees, :through => :student_degrees
  has_many :advisors, :through => :student_degrees
  has_many :codes
end
