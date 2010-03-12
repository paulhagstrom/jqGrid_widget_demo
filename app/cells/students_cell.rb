class StudentsCell < JqgridWidgetCell

  def _setup
    super do |col|
      col.add_column('statuses.name', :width => 50, :custom => :custom_status)
      col.add_column('graduated', :width => 40, :label => 'Grad?', :custom => :custom_graduated)
      col.add_column('graduating', :width => 50, :label => 'G Year', :sortable => true, :custom => :custom_graduating)
      col.add_column('other_degrees', :width => 110, :label => 'Other degrees', :sortable => true)
    end
    eager_load :status
    @jqgrid_options.update({
      :collapse_if_empty => true,
      :caption => 'Student/Program',
      :height => 50
    })
    render
  end
  
  def custom_status(student)
    student.status.name
  end

  def custom_graduated(student)
     (student.graduated ? 'Yes' : 'No')
  end

  def custom_graduating(student)
    student.graduating.to_s
  end
  
  def scoped_model
    parent.record.students
  end
  
  def select_on_load
    true
  end
    
end
