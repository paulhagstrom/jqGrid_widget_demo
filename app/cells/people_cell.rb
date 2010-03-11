class PeopleCell < JqgridWidgetCell
  
  def _setup
    super do |col|
      # col.add_column('name', :width => 100, :sortable => true)
      col.add_column('name', :width => 100, :sortable => true, :panel => '_panel', :panel_under_row => true)
      col.add_column('degrees', :width => 175, :custom => :custom_degrees)
      col.add_column('profiles', :width => 175, :custom => :custom_profiles)
    end
    # @row_panel_under_row = true
    @caption = 'People'
    @row_panel = ''
    
    @filters = [
      ['all', {:name => 'All'}],
      ['students', {:name => 'Students', :include => [:students], :conditions => ['students.id > ?', 0], :subfilters => [
        ['degree', {:name => 'Degrees', :include => {:students => :student_degrees},
          :conditions => 'student_degrees.degree_id in (?)',
            :options => Degree.find(:all).map {|x| [x.id, x.name]}}],
        ['program', {:name => 'Programs', :conditions => 'students.program_id in (?)',
          :options => Program.find(:all).map {|x| [x.id, x.name]}}],
        ['advisor', {:name => 'Advisors', :include => {:students => :advisors}, :conditions => 'advisors.employee_id in (?)',
          :options => EmployeeSection.find(:all, :include => {:employee => :person},
            :conditions => {:is_advisor => true}).map {|x| [x.id, x.employee.person.name]}}],
        ['status', {:name => 'Status', :conditions => 'students.status_id in (?)',
          :options => Status.find(:all).map {|x| [x.id, x.name]}}],
        ]}],
      ['employees', {:name => 'Faculty/Staff', :include => [:employees], :conditions => ['employees.id > ?', 0], :subfilters => [
        ['section', {:name => 'Sections', :include => {:employees => :employee_sections}, :conditions => 'employee_sections.section_id in (?)',
          :options => Section.find(:all).map {|x| [x.id, x.name]}}],
          ]}],
    ]
    render
  end
    	  
  def custom_degrees(person)
    student_out = ''
    for student in person.students
      deg_out = ''
      for degree in student.degrees
        deg_out = deg_out + degree.program.name + ':' + degree.name
        adv_out = ''
        comma = ''
        for advisor in degree.advisors
          adv_out = comma + adv_out + advisor.employee.person.name
          comma = ', '
        end
        if adv_out.length > 0
          deg_out = deg_out + ' (' + adv_out + ')'
        end
        deg_out = '<li>' + deg_out + '</li>'
      end
      if student.other_degrees.length > 0
        deg_out = deg_out + '<li>' + student.other_degrees + '</li>'
      end
      deg_out = deg_out + '<li>' + (student.status.name rescue 'status unset') + '; ' +
        (student.graduated ? 'Graduated' : 'Graduating') + ' ' + student.graduating.to_s + '</li>'
      code = Code.find(:first, :include => :semester, :conditions => {:student_id => student.id}, :order => 'semesters.start_date DESC')
      deg_out = (deg_out + '<li>AAC:' + code.code.to_s  + '</li>') if code
      student_out = student_out + '<ul>' + deg_out + '</ul>'
    end
    student_out
  end
  
  def custom_profiles(person)
    profile_out = ''
    for employee in person.employees
      sec_out = ''
      for employee_section in employee.employee_sections
        sec_out = sec_out + employee_section.section.name + ':' + employee_section.title
        sec_out = '<li>' + sec_out + '</li>'
      end
      if employee.blurb.length > 0
        sec_out = sec_out + '<li>' + employee.blurb + '</li>'
      end
      profile_out = profile_out + '<ul>' + sec_out + '</ul>'
    end
    profile_out
  end
  
end
