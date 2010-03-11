class StudentsCell < JqgridWidgetCell

  def _setup
    super do |col|
      col.add_column('statuses.name', :width => 50, :custom => :custom_status)
      col.add_column('graduated', :width => 40, :label => 'Grad?', :custom => :custom_graduated)
      col.add_column('graduating', :width => 50, :label => 'G Year', :sortable => true, :custom => :custom_graduating)
      col.add_column('other_degrees', :width => 110, :label => 'Other degrees', :sortable => true)
    end
    @filters.assoc('all')[1][:include] = [:status]
    @collapse_if_empty = true
    @caption = 'Student/Program'
    render
  end
  
  def custom_status(student)
    student.status.name
  end

  def custom_graduated(student)
     (student.graduated ? 'Yes' : 'No')
  end

  def custom_graduating(student)
    student.graduating.to_s
  end
  
  def scoped_model
    parent.record.students
  end
  
  def select_first_on_load
    true
  end
  
  # contacts = @person.contacts.find(:all, :include => :contact_type, :order => 'contact_types.name')

  # for student in students
  #   students_formatted << {:id => student.id, :cell => [
  #     student.status.name,
  #     (student.graduated ? 'Yes' : 'No'),
  #     student.graduating.to_s,
  #     student.other_degrees,
  #     # '<span class="ui-icon ui-icon-trash"></span>'
  #     ]}
  # end

  # height: 50,
  #     colNames:['Status', 'Grad?', 'G Year', 'Other degrees'],
  #     colModel:[
  #   {name:'status',index:'status', sortable:false, width:50},
  #   {name:'graduated',index:'graduated', sortable:false, width:40},
  #   {name:'graduating',index:'graduating', sortable:true, width:50},
  #   {name:'otherdeg',index:'otherdeg', sortable:true, width:110}
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
