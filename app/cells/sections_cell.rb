class SectionsCell < JqgridWidgetCell
  
  def _setup
    super do |col|
      col.add_column('name', :width => 100, :sortable => 'default')
    end
    @jqgrid_options.update({
      :height => 75
    })
    render
  end

end
