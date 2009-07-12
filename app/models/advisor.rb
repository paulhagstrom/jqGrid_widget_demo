class Advisor < ActiveRecord::Base
  belongs_to :student_degree
  belongs_to :employee
end
