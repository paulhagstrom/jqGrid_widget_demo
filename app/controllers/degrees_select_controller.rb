class DegreesSelectController < JqgridWidgetController
  
  layout 'admin_jquery'

  # This is a slightly more complicated version of degrees, with a selector

  def index
    super
    use_widgets do |root|
      root << jqg_top_widget('degree', :cell_class => 'degrees_select', :widget_id => 'degrees_select') do |degwid|
        jqg_child_widget(degwid, 'program', :cell_class => 'program_lookup', :selector_for => :program_id)
      end
    end
    render
  end

  
end
