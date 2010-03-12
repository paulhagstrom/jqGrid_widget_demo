class EmployeesCell < JqgridWidgetCell

  def _setup
    super do |col|
      col.add_column('blurb', :width => 250)
    end
    @jqgrid_options.update({
      :collapse_if_empty => true,
      :caption => 'Profiles',
      :height => 50
    })
    render
  end
  
  def scoped_model
    parent.record.employees
  end
  
  def select_on_load
    true
  end
    
end
