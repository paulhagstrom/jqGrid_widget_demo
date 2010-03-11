class DegreesCell < JqgridWidgetCell
  
  def _setup
    super do |col|
      col.add_column('name', :width => 100, :sortable => 'default')
      col.add_column('section_id', :width => 50, :sortable => false)
      col.add_column('program_id', :width => 50, :sortable => false)
    end
    @caption = 'Degrees'
    @rows_per_page = 20
    render
  end

end
