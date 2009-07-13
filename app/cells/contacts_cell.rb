class ContactsCell < JqgridWidgetCell

  def _setup
    super do |col|
      col.add_column('contact_types.name', :width => 70, :sortable => true, :custom => :custom_type)
      col.add_column('body', :width => 150)
    end
    @filters.assoc('all')[1][:include] = [:contact_type]
    @caption = 'Contacts'
    nil
  end
  
  def custom_type(contact)
    contact.contact_type.name
  end
  # contacts = @person.contacts.find(:all, :include => :contact_type, :order => 'contact_types.name')

  def scoped_model
    parent.record.contacts
  end
  
  # def load
  #   # @parent = Person.find_by_id(params(:person_id))
  #   super
  # end
  
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
