class ApplicationWidgetTree < Apotomo::WidgetTree
  # include JqgridWidgetTree
  # right now I don't have anything in there, but some of this might eventually move into there.
  
  # unedited from the books example
  
  # This is an attempt to create a list/edit/filter widget with two such widgets within
  # Here, the book is the outermost widget, and it contains within it author and publisher widgets
  # Each of the three has a frame and three children: list, detail, and filter
  # draw_list_detail_filter_frame is supposed to create and wire up each of these in a consistent way,
  # which works with the methods in common_cell.rb.
  #
  # After that, some routes of communication need to be established between the outer and inner widgets.
  # The author and publisher frames are children of the book frame, even though they are in some
  # sense properly children of the book's edit panel, in order to avoid having them reset and redrawn
  # whenever the book's edit panel is redrawn.  All of the important stuff here is taken care of in embed_frame.
  
  def draw(root)
    # people_frame = cell(:people, :_frame_start, 'person', :resource => 'person')
    # students_frame = cell(:students, :_frame_start, 'student', :resource => 'student')
    # student_degrees_frame = cell(:student_degrees, :_frame_start, 'student_degree', :resource => 'student_degree')
    # employees_frame = cell(:employees, :_frame_start, 'employee', :resource => 'employee')
    # employeee_sections_frame = cell(:employee_sections, :_frame_start, 'employee_section', :resource => 'employee_section')
    # contacts_frame = cell(:contacts, :_frame_start, 'contact', :resource => 'contact')
    # logs_frame = cell(:logs, :_frame_start, 'log', :resource => 'log')
    
    # people_frame = simple_cell('person')

    # students_frame = simple_cell('student')
    # student_degrees_frame = simple_cell('student_degree')
    # employees_frame = simple_cell('employee')
    # employee_sections_frame = simple_cell('employee_section')
    # contacts_frame = simple_cell('contact')
    # logs_frame = simple_cell('log')

    # All of the others are children of the people frame.
    # Note that this means whenever the people frame is redrawn everybody goes back to start.
    # So, this doesn't seem quite like what I want, does it?  We'll see.
    # root << people_frame

    # people_frame << students_frame
    # people_frame << student_degrees_frame
    # people_frame << employees_frame
    # people_frame << employee_sections_frame
    # people_frame << contacts_frame
    # people_frame << logs_frame

      # create the three frame widgets first
      # book_frame = draw_list_detail_filter_frame('book')
      # author_frame = draw_list_detail_filter_frame('author')
      # publisher_frame = draw_list_detail_filter_frame('publisher')
      # 
      # root << embed_frame(embed_frame(book_frame, author_frame), publisher_frame)
    return root
  end

  def simple_cell(resource, opts = {})
    opts[:cell_sym] ||= resource.pluralize.to_sym
    opts[:prefix] ||= ''
    base_name = opts[:prefix] + resource
    the_cell = cell(opts[:cell_sym], 'index', base_name, :resource => resource)
    # The cell should watch itself for loadList events
    the_cell.watch(:loadList, the_cell.name, :_load_list, the_cell.name)
    return the_cell
    # from the more complex one, so I can remember.  These connections may still need to happen, but probably not between cells.
    # Wire up the communication between panels.
    # frame.watch(:editClick, detail.name, :_edit, list.name)
    # frame.watch(:showClick, detail.name, :_show, list.name)
    # frame.watch(:delClick, detail.name, :_delete, list.name)
    # frame.watch(:editClick, detail.name, :_edit, detail.name)
    # frame.watch(:revealList, list.name, :_list_reveal, detail.name)
    # frame.watch(:dismissList, list.name, :_list_dismiss, detail.name)
    # frame.watch(:dismissPanel, detail.name, :_detail_dismiss, detail.name)
    # frame.watch(:recordChanged, list.name, :_list, detail.name)
    # frame.watch(:newClick, detail.name, :_new, filter.name)
    # frame.watch(:filterClick, filter.name, :_filter_update, filter.name)
    # frame.watch(:filterChanged, list.name, :_list, filter.name)
    # frame.watch(:messagePosted, message.name, :_message, nil)
  end

  # And here is the embed_frame stuff from the other one.
  # parent_detail = parent_frame.name + '_detail'
  # parent_list = parent_frame.name + '_list'
  # child_detail = child_frame.name + '_detail'
  # child_list = child_frame.name + '_list'
  # child_selected = child_frame.name + '_selected'
  # child_resource = child_frame.resource_name
  # child_cell_class = child_resource.pluralize.to_sym
  # 
  # # embed the primary child frame under as a child of the parent frame
  # parent_frame << child_frame
  # # embed the selected panel under the parent's detail panel
  # parent_frame[parent_detail] << cell(child_cell_class, :_selected_start, child_selected, :resource => child_resource)
  # # Handle selections
  # parent_frame.watch(:recordChanged, child_selected, :_selected_update, child_detail)
  # parent_frame.watch(:recordChanged, parent_list, :_list, child_detail)
  # parent_frame.watch(:selectClick, child_selected, :_selected_change, child_list)
  # child_frame[child_detail].watch(:redraw, child_detail, :_show)
  
end
