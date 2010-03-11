class SectionsController < JqgridWidgetController
  
  layout 'admin_jquery'

  # This is the simplest possible screen, in order to test the basics.
  
  def index
    use_widget sections_cell = jqg_top_widget('section')
    super
    @content = render_widget(sections_cell.name)
    render
  end

  
end
