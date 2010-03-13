class StudentDegreesCell < JqgridWidgetCell
  
  def _setup
    super do |col|
      col.add_column('degrees.name', :width => 70, :sortable => true, :custom => :custom_track)
      col.add_column('advisor', :width => 180, :custom => :custom_advisor)
    end
    eager_load [:degree, {:advisors => {:employee => :person}}]
    @jqgrid_options.update({
      :collapse_if_empty => true,
      :single_record_caption => '"Degree track: " + row["degrees.name"]',
      :caption => 'Degree tracks',
      :height => 50
    })
    render
  end
  
  def custom_track(student_degree)
    student_degree.degree.name
  end

  def custom_advisor(student_degree)
    '(Unused)'
  end
  
  def scoped_model
    parent.record.student_degrees
  end
  
  def select_on_load
    true
  end
    
end
