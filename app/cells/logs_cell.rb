class LogsCell < JqgridWidgetCell

  def _setup
    super do |col|
      col.add_column('created_at', :width => 70, :sortable => true, :custom => :custom_date)
      col.add_column('body', :width => 150)
    end
    nil
  end

  def custom_date(log)
    log.created_at.strftime('%m/%d/%Y')
  end
  
  def scoped_model
    parent.record.logs
  end
  
  # logs = @person.logs.find(:all, :order => 'created_at ASC')

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
