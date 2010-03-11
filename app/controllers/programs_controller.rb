class ProgramsController < JqgridWidgetController
  
  layout 'admin_jquery'

  # This is the simplest possible screen, in order to test the basics.
  
  def index
    use_widget programs_cell = jqg_top_widget('program')
    super
    @content = render_widget(programs_cell.name)
    render
  end

  
end
