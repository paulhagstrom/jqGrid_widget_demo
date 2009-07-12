class Degree < ActiveRecord::Base
  belongs_to :section
  belongs_to :program
  has_many :student_degrees
  has_many :advisors, :through => :student_degrees
  has_many :students, :through => :student_degrees
end
