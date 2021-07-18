class ReportPolicy< ApplicationPolicy
  
  # allows only the investigator to conclude(complete/ reject) the report
  def completed?
    # @report.admin == admin
    @report.admin_id == admin.id

  end

  # no gevernment offical shall temper the report. 
  def update?
    admin.admin? and report.pending?

  end

  #delete a report by an admin or if it isn't under investigation or if you are the investigating officer
  def destroy?
    admin.admin? or report.pending? or @report.admin_id == admin.id

  end
  
end
