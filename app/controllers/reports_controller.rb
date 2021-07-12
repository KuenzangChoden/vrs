class ReportsController < ApplicationController
  before_action :set_report, only: %i[ show edit update destroy change_status]
  before_action :authenticate_admin!, except: %i[ new create ]

  # GET /reports or /reports.json
  def index
    @reports = Report.all
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
        print(@admins)
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
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url, notice: "Report was successfully deleted." }
      format.json { head :no_content }
    end
  end

  def change_status
    @report.inprogress! if @report.pending?
    @report.completed! if @report.completed?
    @report.rejected! if @report.rejected?
    redirect_to reports_url, notice: "Report status is changed."
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
