class TeachersController < ApplicationController
  before_action :set_teacher, only: [:show, :edit, :update, :destroy]
  before_action :current_teacher_only, only: [:edit]

  # GET /profiles
  # GET /profiles.json
  def index
#    @teachers = Teacher.all

     @q = Teacher.ransack(params[:q])
     @teachers = @q.result(distinct: true).page(params[:page]).per(12)
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    @teacher = Teacher.new
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @teacher = Teacher.new(teacher_params)
    User.where(:role => 2).each do |admin|
        admin.notify("#{current_user.email} created a teacher profile" )
    end

    respond_to do |format|
      if @teacher.save
        format.html { redirect_to @teacher, notice: 'Teacher was successfully created.' }
        format.json { render :show, status: :created, location: @teacher }
      else
        format.html { render :new }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @teacher.update(teacher_params)
        format.html { redirect_to @teacher, notice: 'Teacher was successfully updated.' }
        format.json { render :show, status: :ok, location: @teacher }
      else
        format.html { render :edit }
        format.json { render json: @teacher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @teacher.destroy
    respond_to do |format|
      format.html { redirect_to teachers_url, notice: 'Teacher was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  #POST

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      @teacher = Teacher.find(params[:id])
    end
    
    def current_teacher_only
        if @teacher == current_user.teacher || current_user.admin?
            
            else
            redirect_to root_path, :alert => "Access denied."
        end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def teacher_params
        params.require(:teacher).permit(:first_name, :last_name, :profile_name, :profile_pic_url, :about_me, :github_username, :codecademy_username, :user_id, :school_id)
    end
end
