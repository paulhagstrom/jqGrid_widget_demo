class EmployeeSection < ActiveRecord::Base
  belongs_to :employee
  belongs_to :section
end
