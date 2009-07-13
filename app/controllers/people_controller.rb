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
    use_widget people_cell = listy_widget('person', opts.merge({:top_widget => 'yes'}))
    embed_widget(people_cell, listy_widget('log', opts))
    embed_widget(people_cell, listy_widget('contact', opts))
    embed_widget(people_cell, employees_cell = listy_widget('employee', opts))
    embed_widget(people_cell, students_cell = listy_widget('student', opts))
    embed_widget(students_cell, student_degrees_cell = listy_widget('student_degree', opts))
    embed_widget(student_degrees_cell, listy_widget('advisor', opts))
    embed_widget(employees_cell, listy_widget('employee_section', opts))
    
    respond_to_event :rowClick, :with => :handle_select
    
    @jqgrid = render_widget(people_cell.name)
  end

  def populate
    [Semester, Status, ContactType, Section, Person, Program, Degree, Student, Employee, Contact,
      StudentDegree, EmployeeSection, Log, Advisor, Code].each do |x|
      x.delete_all
    end
    sem = {}
    stat = {}
    ctyp = {}
    sec = {}
    pers = {}
    prog = {}
    deg = {}
    stud = {}
    emp = {}
    cont = {}
    stdg = {}
    empsec = {}
    code = {}
    [['09/01/2009', true], ['01/01/2010', false]].each do |x|
      (sem[x[0]] = Semester.new(:start_date => x[0], :public => x[2])).save
    end
    ['active', 'inactive', 'other'].each do |x|
      (stat[x] = Status.new(:name => x)).save
    end
    [['email', false], ['phone', true]].each do |x|
      (ctyp[x[0]] = ContactType.new(:name => x[0], :is_private => x[1])).save
    end
    ['RS', 'LX', 'LF'].each do |x|
      (sec[x] = Section.new(:name => x)).save
    end
    ['Paul Hagstrom', 'Joe Student', 'Pierre Student', 'Ed Staff'].each do |x|
      (pers[x] = Person.new(:name => x)).save
    end
    ['BA', 'MA'].each do |x|
      (prog[x] = Program.new(:name => x)).save
    end
    [sem, stat, ctyp, sec, pers, prog].each do |h|
      h.values.each {|x| x.reload}
    end
    [['LX major', 'LX', 'BA'], ['LX minor', 'LX', 'BA'], ['LF major', 'LF', 'BA'], ['LF minor', 'LF', 'BA'], ['LF MA', 'LF', 'MA']].each do |x|
      (deg[x[0]] = Degree.new(:name => x[0], :section_id => sec[x[1]].id, :program_id => prog[x[2]].id)).save
    end
    [['Joe Student', 'BA', 'active', 2010, false], ['Pierre Student', 'BA', 'active', 2010, false]].each do |x|
      (stud[x[0]+x[1]] = Student.new(:person_id => pers[x[0]].id, :program_id => prog[x[1]].id, :status_id => stat[x[2]].id, 
      :graduating => x[3], :graduated => x[4], :other_degrees => '')).save
    end
    ['Paul Hagstrom', 'Ed Staff'].each do |x|
      (emp[x] = Employee.new(:person_id => pers[x].id, :blurb => 'Is alive.')).save
    end
    pers.keys.each do |k|
      (cont[pers[k].id.to_s+'email'] = Contact.new(:person_id => pers[k].id, :contact_type => ctyp['email'], :body => 'a@b.c')).save
      (cont[pers[k].id.to_s+'phone'] = Contact.new(:person_id => pers[k].id, :contact_type => ctyp['phone'], :body => '123-456-7890')).save
    end
    [deg, stud, emp, cont].each do |h|
      h.values.each {|x| x.reload}
    end
    [['Joe StudentBA', 'LX major'], ['Pierre StudentBA', 'LX minor'], ['Pierre StudentBA', 'LF major']].each do |x|
      (stdg[x[0]+x[1]] = StudentDegree.new(:student_id => stud[x[0]].id, :degree_id => deg[x[1]].id)).save
    end
    [['Paul Hagstrom', 'LX', 'ASCP', true], ['Ed Staff', 'RS', 'Help', false]].each do |x|
      (empsec[x[0]+x[1]] = EmployeeSection.new(:employee_id => emp[x[0]].id, :section_id => sec[x[1]].id,
        :title => x[2], :is_advisor => x[3])).save
    end
    [stdg, empsec].each do |h|
      h.values.each {|x| x.reload}
    end
    [['Joe StudentBALX major', 'Paul Hagstrom'], ['Pierre StudentBALX minor', 'Paul Hagstrom']].each do |x|
      (Advisor.new(:student_degree_id => stdg[x[0]].id, :employee_id => emp[x[1]].id)).save
    end
    stud.each do |s, k|
      ['09/01/2009', '01/01/2010'].each do |m|
        (Code.new(:student_id => k.id, :semester_id => sem[m].id, :code => '12345', :provided => false)).save
      end
    end
    (Log.new(:person_id => pers['Joe Student'].id, :body => 'This is a note.')).save
    (Log.new(:person_id => pers['Pierre Student'].id, :body => 'This is a note.')).save

    redirect_to :action => 'index'    
  end
  
end
