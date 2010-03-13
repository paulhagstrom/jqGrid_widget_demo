class ProgramsCell < JqgridWidgetCell
  
  def _setup
    super do |col|
      col.add_column('name', :width => 250, :sortable => 'default')
    end
    @jqgrid_options.update({
      :add_button => true,
      :del_button => true,
      :row_action => 'panel',
      :height => 150
    })
    render
  end

end
