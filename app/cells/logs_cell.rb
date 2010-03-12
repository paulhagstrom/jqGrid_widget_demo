class LogsCell < JqgridWidgetCell

  def _setup
    super do |col|
      col.add_column('created_at', :width => 70, :sortable => true, :custom => :custom_date)
      col.add_column('body', :width => 150)
    end
    @jqgrid_options.update({
      :height => 150
    })
    render
  end

  def custom_date(log)
    log.created_at.strftime('%m/%d/%Y')
  end
  
  def scoped_model
    parent.record.logs
  end

end
