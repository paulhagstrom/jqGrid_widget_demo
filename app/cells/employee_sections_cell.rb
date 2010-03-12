class EmployeeSectionsCell < JqgridWidgetCell

  def _setup
    super do |col|
      col.add_column('sections.name', :index => 'name', :width => 70, :custom => :custom_section, :label => 'Section')
      col.add_column('title', :width => 150)
      col.add_column('advisor', :width => 30, :custom => :custom_advisor)
    end
    eager_load :section
    @jqgrid_options.update({
      :collapse_if_empty => true,
      :single_record_caption => "'Faculty/Staff affiliation: ' + row['sections.name']",
      :caption => 'Faculty/Staff affiliations',
      :height => 75
    })
    render
  end
  
  def custom_section(employee_section)
    employee_section.section.name
  end

  def custom_advisor(employee_section)
    (employee_section.is_advisor ? 'Yes' : 'No')
  end
  
  def scoped_model
    parent.record.employee_sections
  end
    
end
