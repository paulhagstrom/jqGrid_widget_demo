class EmployeesController < JqgridWidgetController
  
  layout 'admin_jquery'

  # This has a subtable.
  
  def index
    use_widget employees_cell = jqg_top_widget('employee', :cell_class => 'employees_standalone')
    embed_widget(employees_cell, jqg_widget('employee_section'))
    super
    @content = render_widget(employees_cell.name)
    render
  end

  
end
