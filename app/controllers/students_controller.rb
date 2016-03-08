require 'open-uri'
require 'nokogiri'
require 'mechanize'
require 'httparty'


class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :current_student_only, only: [:edit]


  
  
  def import
    Student.import(params[:file], params[:classroom_id])
    redirect_to classrooms_path, notice: "Products imported."
  end
  
  
  # GET /students
  # GET /students.json
  def index
      
      @q = Student.ransack(params[:q])
      @students = @q.result(distinct: true).page(params[:page]).per(3)
    
  end

  # GET /students/1
  # GET /students/1.json
  def show
      
#        ca_data_array = @student.update_ca_data
#
#        @ca_badges = ca_data_array[2]
#        @ca_total_points = ca_data_array[3]
#        @ca_last_coded = ca_data_array.last
#        
#        @ca_datum = CaDatum.create(:student_id => @student.id, :total_points => @ca_total_points)
        @ca_datum = @student.ca_data.last
        
        @badges = @student.badges_array
        
  end

  # GET /students/new
  def new
    @student = Student.new
    
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)
    @student.user.update_attribute(:role, :student)
    ca_data_array = @student.update_ca_data
    
    ca_badges = ca_data_array[2]
    ca_total_points = ca_data_array[3]
    ca_last_coded = ca_data_array.last
    
    ca_datum = CaDatum.create(:student_id => @student.id, :total_points => ca_total_points)
    
    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to @student.classroom, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end
    
    def current_student_only
        if @student == current_user.student || current_user.admin?
        
        else
            redirect_to root_path, :alert => "Access denied."
        end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
        params.require(:student).permit(:first_name, :last_name, :profile_name, :profile_pic_url, :about_me, :github_username, :codecademy_username, :user_id, :classroom_id, :school_id, :devpost_username, :credly_member_id, :cloud9_username )
    end
end
