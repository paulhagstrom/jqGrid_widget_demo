class DegreesCell < JqgridWidgetCell
  
  def _setup
    super do |col|
      col.add_column('name', :width => 100, :sortable => 'default')
      col.add_column('section_id', :width => 50, :sortable => false, :custom => :section_name)
      col.add_column('program_id', :width => 50, :sortable => false, :custom => :program_name)
    end
    @jqgrid_options.update({
      :rows_per_page => 20,
      :height => 350
    })
    render
  end

  def section_name(degree)
    degree.section_id ? degree.section.name : '(??)'
  end

  def program_name(degree)
    degree.program_id ? degree.program.name : '(??)'
  end

end
