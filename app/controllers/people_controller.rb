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
  def peoplecell
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
    
  # def load_table
  #   rows_formatted = []
  #   page, limit, sidx, sord = params[:page].to_i, params[:rows].to_i, params[:sidx], params[:sord]
  #   sidx ||= '1'
  #   sord ||= 'asc'
  #   if @person = Person.find_by_id(params[:id])
  #     contacts = @person.contacts.find(:all, :include => :contact_type, :order => 'contact_types.name')
  #     count = contacts.size
  #     total_pages = (count > 0 and limit > 0) ? count/limit : 0
  #     page = total_pages if page > total_pages
  #     start = limit*page - limit
  #     for contact in contacts
  #       rows_formatted << {:id => contact.id, :cell => [
  #         contact.contact_type.name,
  #         contact.body,
  #         # '<span class="ui-icon ui-icon-trash"></span>'
  #         ]}
  #     end
  #   end
  #   @json_out = {:page => page, :total => total_pages, :records => count, :rows => rows_formatted}
  #   respond_to do |format|
  #     format.json {render :json => @json_out}
  #   end
  # end
  # 
  # # TODO: Merge this into index and handle the difference with respond_to
  # # TODO: Get the filters working
  # def load_person_table
  #   page, limit, sidx, sord, search, livesearch = params[:page].to_i, params[:rows].to_i, params[:sidx], params[:sord], params[:_search], params[:_livesearch]
  #   sidx ||= '1'
  #   sord ||= 'asc'
  #   if (search == 'true' || livesearch == 'true')
  #     people = Person.find(:all, :order => sidx + ' ' + sord, :conditions => ['name LIKE ?', "%#{params[:name]}%"])      
  #   else
  #     people = Person.find(:all, :order => sidx + ' ' + sord)
  #   end
  #   count = people.size
  #   total_pages = (count > 0 and limit > 0) ? count/limit : 0
  #   page = total_pages if page > total_pages
  #   start = limit*page - limit
  #   people_formatted = []
  #   for person in people
  #     student_out = ''
  #     for student in person.students
  #       deg_out = ''
  #       for degree in student.degrees
  #         deg_out = deg_out + degree.program.name + ':' + degree.name
  #         adv_out = ''
  #         comma = ''
  #         for advisor in degree.advisors
  #           adv_out = comma + adv_out + advisor.employee.person.name
  #           comma = ', '
  #         end
  #         if adv_out.length > 0
  #           deg_out = deg_out + ' (' + adv_out + ')'
  #         end
  #         deg_out = '<li>' + deg_out + '</li>'
  #       end
  #       if student.other_degrees.length > 0
  #         deg_out = deg_out + '<li>' + student.other_degrees + '</li>'
  #       end
  #       deg_out = deg_out + '<li>' + (student.status.name rescue 'status unset') + '; ' +
  #         (student.graduated ? 'Graduated' : 'Graduating') + ' ' + student.graduating.to_s + '</li>'
  #       code = Code.find(:first, :include => :semester, :conditions => {:student_id => student.id}, :order => 'semesters.start_date DESC')
  #       deg_out = deg_out + '<li>AAC:' + code.code.to_s  + '</li>'
  #       student_out = student_out + '<ul>' + deg_out + '</ul>'
  #     end
  #     profile_out = ''
  #     for employee in person.employees
  #       sec_out = ''
  #       for employee_section in employee.employee_sections
  #         sec_out = sec_out + employee_section.section.name + ':' + employee_section.title
  #         sec_out = '<li>' + sec_out + '</li>'
  #       end
  #       if employee.blurb.length > 0
  #         sec_out = sec_out + '<li>' + employee.blurb + '</li>'
  #       end
  #       profile_out = profile_out + '<ul>' + sec_out + '</ul>'
  #     end
  #     people_formatted << {:id => person.id, :cell => [
  #       person.name,
  #       student_out,
  #       profile_out,
  #       # '<span class="ui-icon ui-icon-trash"></span>'
  #       ]}
  #   end
  #   @json_out = {:page => page, :total => total_pages, :records => count, :rows => people_formatted}
  #   # $SQL = "SELECT a.id, a.invdate, b.name, a.amount,a.tax,a.total,a.note FROM invheader a, clients b WHERE a.client_id=b.client_id ORDER BY $sidx $sord LIMIT $start , $limit";
  #   respond_to do |format|
  #     format.json {render :json => @json_out}
  #   end
  # end
  # 
  # def load_person_contact_table
  #   contacts_formatted = []
  #   page, limit, sidx, sord = params[:page].to_i, params[:rows].to_i, params[:sidx], params[:sord]
  #   sidx ||= '1'
  #   sord ||= 'asc'
  #   if @person = Person.find_by_id(params[:id])
  #     contacts = @person.contacts.find(:all, :include => :contact_type, :order => 'contact_types.name')
  #     count = contacts.size
  #     total_pages = (count > 0 and limit > 0) ? count/limit : 0
  #     page = total_pages if page > total_pages
  #     start = limit*page - limit
  #     for contact in contacts
  #       contacts_formatted << {:id => contact.id, :cell => [
  #         contact.contact_type.name,
  #         contact.body,
  #         # '<span class="ui-icon ui-icon-trash"></span>'
  #         ]}
  #     end
  #   end
  #   @json_out = {:page => page, :total => total_pages, :records => count, :rows => contacts_formatted}
  #   respond_to do |format|
  #     format.json {render :json => @json_out}
  #   end
  # end
  # 
  # def load_person_log_table
  #   logs_formatted = []
  #   page, limit, sidx, sord = params[:page].to_i, params[:rows].to_i, params[:sidx], params[:sord]
  #   sidx ||= '1'
  #   sord ||= 'asc'
  #   if @person = Person.find_by_id(params[:id])
  #     logs = @person.logs.find(:all, :order => 'created_at ASC')
  #     count = logs.size
  #     total_pages = (count > 0 and limit > 0) ? count/limit : 0
  #     page = total_pages if page > total_pages
  #     start = limit*page - limit
  #     for log in logs
  #       logs_formatted << {:id => log.id, :cell => [
  #         log.created_at.strftime('%m/%d/%Y'),
  #         log.body,
  #         # '<span class="ui-icon ui-icon-trash"></span>'
  #         ]}
  #     end
  #   end
  #   @json_out = {:page => page, :total => total_pages, :records => count, :rows => logs_formatted}
  #   respond_to do |format|
  #     format.json {render :json => @json_out}
  #   end
  # end
  # 
  # def load_person_student_table
  #   students_formatted = []
  #   page, limit, sidx, sord = params[:page].to_i, params[:rows].to_i, params[:sidx], params[:sord]
  #   sidx ||= '1'
  #   sord ||= 'asc'
  #   if @person = Person.find_by_id(params[:id])
  #     students = @person.students.find(:all, :order => 'created_at ASC')
  #     count = students.size
  #     total_pages = (count > 0 and limit > 0) ? count/limit : 0
  #     page = total_pages if page > total_pages
  #     start = limit*page - limit
  #     for student in students
  #       students_formatted << {:id => student.id, :cell => [
  #         student.status.name,
  #         (student.graduated ? 'Yes' : 'No'),
  #         student.graduating.to_s,
  #         student.other_degrees,
  #         # '<span class="ui-icon ui-icon-trash"></span>'
  #         ]}
  #     end
  #   end
  #   @json_out = {:page => page, :total => total_pages, :records => count, :rows => students_formatted}
  #   respond_to do |format|
  #     format.json {render :json => @json_out}
  #   end
  # end
  # 
  # def load_student_degree_table
  #   degrees_formatted = []
  #   page, limit, sidx, sord = params[:page].to_i, params[:rows].to_i, params[:sidx], params[:sord]
  #   sidx ||= '1'
  #   sord ||= 'asc'
  #   if @student = Student.find_by_id(params[:id])
  #     student_degrees = @student.student_degrees.find(:all, :order => 'created_at ASC')
  #     count = student_degrees.size
  #     total_pages = (count > 0 and limit > 0) ? count/limit : 0
  #     page = total_pages if page > total_pages
  #     start = limit*page - limit
  #     for student_degree in student_degrees
  #       degrees_formatted << {:id => student_degrees.id, :cell => [
  #         student_degree.degree.name,
  #         '(advisor)',
  #         # '<span class="ui-icon ui-icon-trash"></span>'
  #         ]}
  #     end
  #   end
  #   @json_out = {:page => page, :total => total_pages, :records => count, :rows => degrees_formatted}
  #   respond_to do |format|
  #     format.json {render :json => @json_out}
  #   end
  # end
  # 
  # def load_person_employee_table
  #   employees_formatted = []
  #   page, limit, sidx, sord = params[:page].to_i, params[:rows].to_i, params[:sidx], params[:sord]
  #   sidx ||= '1'
  #   sord ||= 'asc'
  #   if @person = Person.find_by_id(params[:id])
  #     employees = @person.employees.find(:all)
  #     count = employees.size
  #     total_pages = (count > 0 and limit > 0) ? count/limit : 0
  #     page = total_pages if page > total_pages
  #     start = limit*page - limit
  #     for employee in employees
  #       employees_formatted << {:id => employee.id, :cell => [
  #         employee.blurb,
  #         # '<span class="ui-icon ui-icon-trash"></span>'
  #         ]}
  #     end
  #   end
  #   @json_out = {:page => page, :total => total_pages, :records => count, :rows => employees_formatted}
  #   respond_to do |format|
  #     format.json {render :json => @json_out}
  #   end
  # end
  # 
  # def load_employee_section_table
  #   employees_formatted = []
  #   page, limit, sidx, sord = params[:page].to_i, params[:rows].to_i, params[:sidx], params[:sord]
  #   sidx ||= '1'
  #   sord ||= 'asc'
  #   if @employee = Employee.find_by_id(params[:id])
  #     employee_sections = @employee.employee_sections.find(:all)
  #     count = employee_sections.size
  #     total_pages = (count > 0 and limit > 0) ? count/limit : 0
  #     page = total_pages if page > total_pages
  #     start = limit*page - limit
  #     for employee_section in employee_sections
  #       employees_formatted << {:id => employee_sections.id, :cell => [
  #         employee_section.section.name,
  #         employee_section.title,
  #         (employee_section.is_advisor ? 'Yes' : 'No'),
  #         # '<span class="ui-icon ui-icon-trash"></span>'
  #         ]}
  #     end
  #   end
  #   @json_out = {:page => page, :total => total_pages, :records => count, :rows => employees_formatted}
  #   respond_to do |format|
  #     format.json {render :json => @json_out}
  #   end
  # end
  # 
  # def edit_panel
  #   case params[:table]
  #   when 'people_list'
  #     @person = Person.find_by_id(params[:id])
  #     @students = @person.students
  #     case params[:panel].to_i
  #     when 0
  #       partial = '/app/cells/people/people_panel_name'
  #     when 1
  #       partial = '/app/cells/people/people_panel_student_panel'
  #     else
  #       partial = '/app/cells/people/people_panel_other_panel'
  #     end
  #     render :partial => partial
  #   when 'person_contacts_list'
  #     @contact = Contact.find_by_id(params[:id])
  #     render :partial => 'contacts_panel'
  #   when 'person_logs_list'
  #     @log = Log.find_by_id(params[:id])
  #     render :partial => 'logs_panel'
  #   end
  #   # render :text => html
  # end
  # 
  # def name_submit
  #   @person = Person.find_by_id(params[:id])
  #   @person.update_attributes(params[:person])
  #   render :partial => 'name_panel'
  # end
  # 
  # def student_submit
  #   @person = Person.find_by_id(params[:id])
  #   # @person.update_attributes(params[:person])
  #   render :partial => 'student_panel'
  # end

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
