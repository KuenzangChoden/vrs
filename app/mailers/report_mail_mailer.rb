class ReportMailMailer < ApplicationMailer
	def notify_user(report)
		@report = report

		mail(to: @report.email, subject: "VRS: Report sent")
	end

	def notify_admin(admin)
		@admin = admin

		mail(to: @admin.email, subject: "VRS: New Report")
	end
end
