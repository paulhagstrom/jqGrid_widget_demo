class ProgramsCell < JqgridWidgetCell
  
  def _setup
    super do |col|
      col.add_column('name', :width => 250, :sortable => 'default')
    end
    @jqgrid_options.update({
      :height => 50
    })
    render
  end

end
