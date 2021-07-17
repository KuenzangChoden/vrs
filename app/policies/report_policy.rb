class ReportPolicy< ApplicationPolicy
  

  def completed?
    report.admin == admin
  end

  def rejected?
    report.admin == admin
  end
end
