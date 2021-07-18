class ReportsController < ApplicationController
  before_action :set_report, only: %i[ show edit update destroy change_status completed rejected]
  before_action :authenticate_admin!, except: %i[ new create ]

  # GET /reports or /reports.json
  def index
    
    @reports = Report.paginate(page: params[:page], per_page: 15)

  end

  # GET /reports/1 or /reports/1.json
  def show
  end

  # GET /reports/new
  def new
    @report = Report.new
  end

  # GET /reports/1/edit
  def edit
  end

  # POST /reports or /reports.json
  def create
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        ReportMailMailer.notify_user(@report).deliver
        @admins= Admin.all
      
        @admins.each do |admin|
          ReportMailMailer.notify_admin(admin).deliver
        end
        format.html { redirect_to root_path, notice: "Report was successfully submitted." }
        format.json { render :show, status: :created, location: @report }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1 or /reports/1.json
  def update
    respond_to do |format|
      authorize @report
      if @report.update(report_params)
        format.html { redirect_to @report, notice: "Report was successfully updated." }
        format.json { render :show, status: :ok, location: @report }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1 or /reports/1.json
  def destroy
    authorize @report, :destroy?
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: "Report was successfully deleted." }
      format.json { head :no_content }
    end
  end

  #Changing the status of the case
  def change_status
    if @report.pending? #when the case is just reported
      @report.inprogress!
      @report.update(admin_id: current_admin.id)
      @report.update(investigation_date: DateTime.now)
      ReportMailMailer.notify_user(@report).deliver
      redirect_to request.referrer, notice: "The report is under your investigation now."
    end 
    
  end

  def completed
    authorize @report, :completed?
    @report.completed! 
    @report.update(conclusion_date: DateTime.now)
    ReportMailMailer.notify_user(@report).deliver
    redirect_to request.referrer, notice: "The report is completed."
  end

  def rejected
    @report.rejected! 
    @report.update(conclusion_date: DateTime.now)
    ReportMailMailer.notify_user(@report).deliver
    redirect_to request.referrer, notice: "The report is rejected."
  end

  def view_by
    Groupdate.time_zone = false
    type = params[:type]
    if type== "daily"
      @reports= Report.group_by_day(:created_at, reverse: true).count
    end

    if type== "weekly"
      @reports= Report.group_by_week(:created_at, week_start: :monday, reverse: true).count
    end

    if type== "monthly"
      @reports= Report.group_by_month(:created_at, format: "%b %Y", reverse: true).count
    end

    if type== "yearly"
      @reports= Report.group_by_year(:created_at, format: "%b %Y", reverse: true).count
    end

  end

  def grouped_report
    type = params[:type]
    date= Date.parse(params[:date])
    
    if type== "daily"
      
      @reports= Report.where(:created_at => date.beginning_of_day..date.end_of_day).paginate(page: params[:page], per_page: 15)

    end

    if type== "weekly"
     
      @reports= Report.where(:created_at => date.beginning_of_day..date.end_of_week).paginate(page: params[:page], per_page: 15)

    end

    if type== "monthly"
     
      @reports= Report.where(:created_at => date.beginning_of_day..date.end_of_month).paginate(page: params[:page], per_page: 15)

    end

    if type== "yearly"
     
      @reports= Report.where(:created_at => date.beginning_of_day..date.end_of_year).paginate(page: params[:page], per_page: 15)

    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def report_params
      params.require(:report).permit(:name, :email, :phone, :address, :vtype, images: [], videos: [])
    end
end
