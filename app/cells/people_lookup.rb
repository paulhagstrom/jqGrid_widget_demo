class PeopleLookup < JqgridWidgetCell
  
  def _setup
    super do |col|
      col.add_choice_column(:width => 24)
      col.add_column('name', :width => 250, :sortable => true)
    end
    
    @jqgrid_options.update({
      # :row_action => 'row_panel',
      # :pager => {:rows => 20, :rows_options => '2,5,2500'},
      # :sortname => 'name',
      :row_action => 'nothing',
      :height => 350
    })
    # @selector_for = :person_id
    
    # @filters = [
    #   ['all', {:name => 'All'}],
    #   ['students', {:name => 'Students', :include => [{:students => [:student_degrees, :advisors]}], :conditions => ['students.id > ?', 0], :subfilters => [
    #     ['degree', {:name => 'Degrees', 
    #       :conditions => 'student_degrees.degree_id in (?)',
    #         :options => Degree.find(:all).map {|x| [x.id, x.name]}}],
    #     ['program', {:name => 'Programs', :conditions => 'students.program_id in (?)',
    #       :options => Program.find(:all).map {|x| [x.id, x.name]}}],
    #     ['advisor', {:name => 'Advisors', :conditions => 'advisors.employee_id in (?)',
    #       :options => EmployeeSection.find(:all, :include => {:employee => :person},
    #         :conditions => {:is_advisor => true}).map {|x| [x.id, x.employee.person.name]}}],
    #     ['status', {:name => 'Status', :conditions => 'students.status_id in (?)',
    #       :options => Status.find(:all).map {|x| [x.id, x.name]}}],
    #     ]}],
    #   ['employees', {:name => 'Faculty/Staff', :include => [{:employees => :employee_sections}], :conditions => ['employees.id > ?', 0], :subfilters => [
    #     ['section', {:name => 'Sections', :conditions => 'employee_sections.section_id in (?)',
    #       :options => Section.find(:all).map {|x| [x.id, x.name]}}],
    #       ]}],
    # ]
    render
  end

  # If a child widget is serving as a glorified popup menu, where the selection in the child table
  # determines the value of a field in the parent, then set selector_for for the child table to be
  # the field (of the child) from which the id is drawn.  As a symbol.  Like :thingie_id.
  # Returning nil means that the child is showing something like a one-to-many relation.
  # TODO: This could potentially be drawn from information about has_many or belongs_to settings in
  # the model.  But setting it explicitly is ok for now.
  # def selector_for
  #   :person_id
  # end      
  
end
