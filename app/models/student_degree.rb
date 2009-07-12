class StudentDegree < ActiveRecord::Base
  belongs_to :student
  belongs_to :degree
  has_many :advisors
end
