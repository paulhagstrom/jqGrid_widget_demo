class EmployeesStandalone < JqgridWidgetCell

  # This is the standalone version of the employees editor (the non-standalone one is a subtable for people)
  # Things to notice:
  # eager_load :person is required in order to load the person record for each employee.
  # The custom column has a special label.
  # The templates for this are in the "employees_standalone" directory
  
  def _setup
    super do |col|
      col.add_column('people.name', :width => 100, :label => 'Name', :sortable => 'default', :custom => :employee_person_name)
      col.add_column('blurb', :width => 250)
    end
    eager_load :person
    @jqgrid_options.update({
      :collapse_if_empty => true,
      :height => 50
    })
    render
  end
  
  def employee_person_name(employee)
    employee.person_id ? employee.person.name : '(??)'
  end
    
end
