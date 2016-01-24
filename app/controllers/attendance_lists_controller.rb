class AttendanceListsController < ApplicationController
  before_action :set_attendance_list, only: [:show, :edit, :update, :destroy]

  # GET /attendance_lists
  # GET /attendance_lists.json
  def index
    @attendance_lists = AttendanceList.all
  end

  # GET /attendance_lists/1
  # GET /attendance_lists/1.json
  def show
  end

  # GET /attendance_lists/new
  def new
    @attendance_list = AttendanceList.new
    @classroom = Classroom.find(params[:classroom_id])
    @classroom.enrollments.each do |enrollment|
        
        if enrollment.is_verified == true
            @attendance_list.attendance_data.build(:enrollment_id => enrollment.id)
        end
#        @attendance_list.attendance_data << AttendanceDatum.new(:enrollment_id => enrollment.id)
    end
    
  end

  # GET /attendance_lists/1/edit
  def edit
      @classroom = @attendance_list.classroom
  end

  # POST /attendance_lists
  # POST /attendance_lists.json
  def create
    @attendance_list = AttendanceList.new(attendance_list_params)
    @classroom = Classroom.find(attendance_list_params[:classroom_id])
    
    
    respond_to do |format|
      if @attendance_list.save
          format.html { redirect_to @classroom, notice: 'Attendance list was successfully created.' }
        format.json { render :show, status: :created, location: @attendance_list }
      else
        format.html { render :new }
        format.json { render json: @attendance_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attendance_lists/1
  # PATCH/PUT /attendance_lists/1.json
  def update
    @classroom = @attendance_list.classroom

    
    respond_to do |format|
      if @attendance_list.update(attendance_list_params)
          format.html { redirect_to @classroom, notice: 'Attendance list was successfully updated.' }
        format.json { render :show, status: :ok, location: @attendance_list }
      else
        format.html { render :edit }
        format.json { render json: @attendance_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendance_lists/1
  # DELETE /attendance_lists/1.json
  def destroy
    @classroom = @attendance_list.classroom
    @attendance_list.destroy
    respond_to do |format|
      format.html { redirect_to @classroom, notice: 'Attendance list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance_list
      @attendance_list = AttendanceList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attendance_list_params
        params.require(:attendance_list).permit(:classroom_id, :date, attendance_data_attributes: [:id, :enrollment_id, :attendance_list_id, :present]  )
    end
end
