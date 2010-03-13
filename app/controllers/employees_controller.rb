class EmployeesController < JqgridWidgetController
  
  layout 'admin_jquery'

  # This has a subtable.
  
  def index
    use_widget employees_cell = jqg_top_widget('employee', :cell_class => 'employees_standalone')
    embed_widget(employees_cell, jqg_widget('employee_section'))
    embed_widget(employees_cell, jqg_widget('person', :cell_class => 'people_lookup'))
    super
    @content = render_widget(employees_cell.name)
    render
  end

  
end
