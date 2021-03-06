class DegreesSelect < JqgridWidgetCell

  helper_method :program_name
  
  def _setup
    super do |col|
      col.add_column('name', :width => 100, :sortable => 'default')
      col.add_column('section_id', :width => 50, :sortable => false, :custom => :section_name)
      col.add_column('program_id', :width => 50, :sortable => false, :custom => :program_name)
    end
    eager_load :program
    @jqgrid_options.update({
      :rows_per_page => 20,
      :height => 350
    })
    @selectors = {'program' => [:program_id, :program_name]}
    render
  end
  
  def section_name(degree)
    degree.section_id ? degree.section.name : '(??)'
  end
  
  def program_name(degree)
    degree.program_id ? degree.program.name : '(??)'
  end

end
