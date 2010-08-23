class EmployeesController < JqgridWidgetController
  
  layout 'admin_jquery'

  # This demonstrates a list with a child list and a selector list.

  def index
    super
    use_widgets do |root|
      root << jqg_top_widget('employee', :cell_class => 'employees_standalone') do |empwid|
        jqg_child_widget(empwid, 'employee_section')
        jqg_child_widget(empwid, 'person', :cell_class => 'people_lookup', :selector_for => :person_id)
      end
    end
    render
  end
  
  
end
