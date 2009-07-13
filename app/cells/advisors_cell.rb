class AdvisorsCell < JqgridWidgetCell
  
  def _setup
    super do |col|
      col.add_column('employee_id', :width => 150, :custom => :custom_advisor)
      col.add_column('start_date', :width => 50, :sortable => true)
      col.add_column('end_date', :width => 50, :sortable => true)
    end
    @filters.assoc('all')[1][:include] = [{:employee => :person}]
    @collapse_if_empty = true
    @caption = 'Advisors'
    # @row_panel = ''
    nil
  end
  
  # TODO: Use a CSS class for the table display options
  def custom_advisor(advisor)
    advisor.employee.person.name
  end
  
  def scoped_model
    parent.record.advisors
  end
    
end
