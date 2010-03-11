class PeopleController < JqgridWidgetController
  
  layout 'admin_jquery'

  # Here's the setup:
  # The people_cell is the primary widget, with the list of people.
  # The selections in all of the subordinate cells depend on the selection in this list.
  # The contacts, logs, employees, and students widgets are children of the people widget.
  # The employee-section and student-degrees cells are children of the employees and students widget, respectively.
  # When any row on any widget is clicked on, jqGrid fires a :rowClick event, which the controller catches.
  # The controller tells the source widget to select the desired record and announce that a new record was selected (:recordSelected)
  # Children watch their parents for :recordSelected events and if the parent's record selection has changed, the child reloads itself.
  # Parents watch their children for :recordUpdated events and redraw themselves to reflect the child's changes.
  # The "top widget" designation marks the uppermost parent in the widget group (there might be more than one).
  # It is used in determining whether we can assume ahead of time that the list will start empty (when the parent's selection is empty)
  def index
    opts = {:prefix => 'per_'}
    use_widget people_cell = jqg_top_widget('person', opts)
    embed_widget(people_cell, jqg_widget('log', opts))
    embed_widget(people_cell, jqg_widget('contact', opts))
    embed_widget(people_cell, employees_cell = jqg_widget('employee', opts))
    embed_widget(people_cell, students_cell = jqg_widget('student', opts))
    embed_widget(students_cell, student_degrees_cell = jqg_widget('student_degree', opts))
    embed_widget(student_degrees_cell, jqg_widget('advisor', opts))
    embed_widget(employees_cell, jqg_widget('employee_section', opts))
    
    # respond_to_event :rowClick, :with => :handle_select
    super
    @content = render_widget(people_cell.name)
    render
  end

end
