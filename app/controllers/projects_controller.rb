class ProjectsController < ApplicationController
    before_action :set_project, only: [:show, :edit, :update, :destroy], :except => [:add]

  # GET /projects
  # GET /projects.json
  def index
#    @projects = Project.page(params[:page]).per(3)

    @q = Project.ransack(params[:q])
    @projects = @q.result.includes(:student).page(params[:page]).per(12)
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
      @devpost_data = @project.fetch_devpost_data
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to edit_project_path(@project), notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # POST /projects
  # POST /projects.json
  
  def add
      @project = Project.new
      @repos = current_user.public_repos
      
  end
  
  def import
      
      @project = Project.create(params[project_params])
      
      respond_to do |format|
          if @project.save
              format.html { redirect_to edit_project_path(@project), notice: 'Project was successfully created.' }
              format.json { render :show, status: :created, location: @project }
              else
              format.html { render :new }
              format.json { render json: @project.errors, status: :unprocessable_entity }
          end
      end
  end
  
  

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to current_user.student, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
        params.require(:project).permit(:name, :tag_line, :description, :image_url, :student_id, :devpost_url, :github_repo_url)
    end
end
