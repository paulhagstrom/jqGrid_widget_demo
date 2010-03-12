class ContactsCell < JqgridWidgetCell

  def _setup
    super do |col|
      col.add_column('contact_types.name', :width => 70, :sortable => true, :custom => :custom_type)
      col.add_column('body', :width => 150)
    end
    eager_load :contact_type
    @jqgrid_options.update({
      :height => 150
    })
    render
  end
  
  def custom_type(contact)
    contact.contact_type.name
  end

  def scoped_model
    parent.record.contacts
  end
  
    
end
