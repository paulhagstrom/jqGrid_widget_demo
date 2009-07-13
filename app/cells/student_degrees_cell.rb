class StudentDegreesCell < JqgridWidgetCell
  
  def _setup
    super do |col|
      col.add_column('degrees.name', :width => 70, :sortable => true, :custom => :custom_track)
      col.add_column('advisor', :width => 180, :custom => :custom_advisor)
    end
    @filters.assoc('all')[1][:include] = [:degree, {:advisors => {:employee => :person}}]
    @collapse_if_empty = true
    @caption = 'Degree tracks'
    @single_record_caption = "'Degree track: ' + row['degrees.name']"
    # @row_panel = ''
    nil
  end
  
  def custom_track(student_degree)
    student_degree.degree.name
  end

  def custom_advisor(student_degree)
    '(Unused)'
  end
  
  def scoped_model
    parent.record.student_degrees
  end
  
  def select_first_on_load
    true
  end
  
  # contacts = @person.contacts.find(:all, :include => :contact_type, :order => 'contact_types.name')

  # if @student = Student.find_by_id(params[:id])
  #   student_degrees = @student.student_degrees.find(:all, :order => 'created_at ASC')
  #   count = student_degrees.size
  #   total_pages = (count > 0 and limit > 0) ? count/limit : 0
  #   page = total_pages if page > total_pages
  #   start = limit*page - limit
  #   for student_degree in student_degrees
  #     degrees_formatted << {:id => student_degrees.id, :cell => [
  #       student_degree.degree.name,
  #       '(advisor)',
  #       # '<span class="ui-icon ui-icon-trash"></span>'
  #       ]}
  #   end
  # end

  # height: 50,
  #     colNames:['Track', 'Advisor'],
  #     colModel:[
  #   {name:'track',index:'track', sortable:true, width:70},
  #   {name:'advisor',index:'advisor', sortable:false, width:180}
  #     ],

  # def filters_available
  #   super.merge({
  #     'ns' => {:name => 'Titles after H', :conditions => ["title > 'H'"]},
  #   })
  # end
  # 
  # def resources_default_order
  #   'authors.name, books.title'
  # end
  # 
  # def attributes_to_update
  #   [:title]
  # end
  # 
  # def child_panels
  #   {'author' => :author_id, 'publisher' => :publisher_id}
  # end
  # 
  # def resources_include
  #   [:author, :publisher]
  # end
  # 
  # def hud_panels
  #   super.merge({
  #     :detail => ['div_book_detail_panels', false],
  #     :message => ['div_book_message', false],
  #   })
  # end  
    
end
