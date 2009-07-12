module YuiPeopleHelper
  def degrees_cell(students)
    comma = ''
    output = ''
    for student in students
      output = output + comma + student.degree.name
      comma = '<br />'
    end
    output
  end
end
