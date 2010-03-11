class ProgramsCell < JqgridWidgetCell
  
  def _setup
    super do |col|
      col.add_column('name', :width => 100, :sortable => 'default')
    end
    @caption = 'Programs'
    render
  end

end
