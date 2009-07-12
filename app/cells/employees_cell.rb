class EmployeesCell < JqgridWidgetCell

  def _setup
    super do |col|
      col.add_column('blurb', :width => 250)
    end
    @collapse_if_empty = true
    nil
  end
  
  def scoped_model
    parent.record.employees
  end
  
  def select_first_on_load
    true
  end
  
  # def custom_type(contact)
  #   contact.contact_type.name
  # end
  # # contacts = @person.contacts.find(:all, :include => :contact_type, :order => 'contact_types.name')
  # 
  # if @person = Person.find_by_id(params[:id])
  #   employees = @person.employees.find(:all)
  #   count = employees.size
  #   total_pages = (count > 0 and limit > 0) ? count/limit : 0
  #   page = total_pages if page > total_pages
  #   start = limit*page - limit
  #   for employee in employees
  #     employees_formatted << {:id => employee.id, :cell => [
  #       employee.blurb,
  #       # '<span class="ui-icon ui-icon-trash"></span>'
  #       ]}
  #   end
  # end

  # height: 50,
  #     colNames:['Blurb'],
  #     colModel:[
  #   {name:'blurb',index:'blurb', sortable:false, width:250}
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
