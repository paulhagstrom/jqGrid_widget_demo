class EmployeeSectionsCell < JqgridWidgetCell

  def _setup
    super do |col|
      col.add_column('sections.name', :width => 70, :custom => :custom_section)
      col.add_column('title', :width => 150)
      col.add_column('advisor', :width => 30, :custom => :custom_advisor)
    end
    @filters.assoc('all')[1][:include] = [:section]
    @collapse_if_empty = true
    nil
  end
  
  def custom_section(employee_section)
    employee_section.section.name
  end

  def custom_advisor(employee_section)
    (employee_section.is_advisor ? 'Yes' : 'No')
  end
  
  def scoped_model
    parent.record.employee_sections
  end
    
  # contacts = @person.contacts.find(:all, :include => :contact_type, :order => 'contact_types.name')

  # if @employee = Employee.find_by_id(params[:id])
  #   employee_sections = @employee.employee_sections.find(:all)
  #   count = employee_sections.size
  #   total_pages = (count > 0 and limit > 0) ? count/limit : 0
  #   page = total_pages if page > total_pages
  #   start = limit*page - limit
  #   for employee_section in employee_sections
  #     employees_formatted << {:id => employee_sections.id, :cell => [
  #       employee_section.section.name,
  #       employee_section.title,
  #       (employee_section.is_advisor ? 'Yes' : 'No'),
  #       # '<span class="ui-icon ui-icon-trash"></span>'
  #       ]}
  #   end
  # end

  # height: 50,
  #     colNames:['Section', 'Title','Adv?'],
  #     colModel:[
  #   {name:'section',index:'section', sortable:true, width:70},
  #   {name:'title',index:'title', sortable:false, width:150},
  #   {name:'advisor',index:'advisor', sortable:false, width:30}
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
