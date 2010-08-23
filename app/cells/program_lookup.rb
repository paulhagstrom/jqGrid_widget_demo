class ProgramLookup < JqgridWidgetCell
  
  def _setup
    super do |col|
      col.add_choice_column(:width => 24)
      col.add_column('name', :width => 250, :sortable => true)
    end
    @jqgrid_options.update({
      # :add_button => true,
      # :del_button => false,
      # :row_action => 'panel',
      :row_action => 'nothing',
      :height => 150
    })
    # @selector_for = :program_id
    render
  end

end
