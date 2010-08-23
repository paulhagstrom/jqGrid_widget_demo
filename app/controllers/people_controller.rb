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
    super
    use_widgets do |root|
      root << jqg_top_widget('person') do |perwid|
        jqg_child_widget(perwid, 'log')
        jqg_child_widget(perwid, 'contact')
        jqg_child_widget(perwid, 'employee') do |empwid|
          jqg_child_widget(empwid, 'employee_section')
        end
        jqg_child_widget(perwid, 'student') do |stuwid|
          jqg_child_widget(stuwid, 'student_degree') do |stdwid|
            jqg_child_widget(stdwid, 'advisor')
          end
        end
      end
    end
    render
  end

end
