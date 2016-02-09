class AttendanceDataController < ApplicationController
    before_action :set_attendance_datum, only: [:show, :edit, :update, :destroy, :mark_as_present]

  # GET /attendance_data
  # GET /attendance_data.json
  def index
    @attendance_data = AttendanceDatum.all
  end

  # GET /attendance_data/1
  # GET /attendance_data/1.json
  def show
  end

  # GET /attendance_data/new
  def new
    @attendance_datum = AttendanceDatum.new
  end

  # GET /attendance_data/1/edit
  def edit
  end
  
  # POST /attendance_data
  # POST /attendance_data.json
  def mark_as_present
     respond_to do |format|
      if @attendance_datum.attendance_list.status == "open"
          @attendance_datum.update_attribute(:present, true)
          format.html { redirect_to @attendance_datum.enrollment.student, notice: 'Attendance Succesfully Marked' }
      else
            format.html { redirect_to @attendance_datum.enrollment.student, notice: 'Attendance Session Closed' }
      end
     end
  end

  # POST /attendance_data
  # POST /attendance_data.json
  def create
    @attendance_datum = AttendanceDatum.new(attendance_datum_params)

    respond_to do |format|
      if @attendance_datum.save
        format.html { redirect_to @attendance_datum, notice: 'Attendance datum was successfully created.' }
        format.json { render :show, status: :created, location: @attendance_datum }
      else
        format.html { render :new }
        format.json { render json: @attendance_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attendance_data/1
  # PATCH/PUT /attendance_data/1.json
  def update
    respond_to do |format|
      if @attendance_datum.update(attendance_datum_params)
        format.html { redirect_to @attendance_datum, notice: 'Attendance datum was successfully updated.' }
        format.json { render :show, status: :ok, location: @attendance_datum }
      else
        format.html { render :edit }
        format.json { render json: @attendance_datum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendance_data/1
  # DELETE /attendance_data/1.json
  def destroy
    @attendance_datum.destroy
    respond_to do |format|
      format.html { redirect_to attendance_data_url, notice: 'Attendance datum was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance_datum
      @attendance_datum = AttendanceDatum.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attendance_datum_params
        params.require(:attendance_datum).permit(:enrollment_id, :attendance_sheet_id, :present)
    end
end
