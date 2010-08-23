class ProgramsController < JqgridWidgetController
  
  layout 'admin_jquery'

  # This is the simplest possible screen, in order to test the basics.
  
  def index
    super
    use_widgets do |root|
      root << jqg_top_widget('program')
    end
    render
  end
  
end
