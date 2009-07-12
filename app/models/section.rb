class Section < ActiveRecord::Base
  has_many :employees
  has_many :degrees
end
