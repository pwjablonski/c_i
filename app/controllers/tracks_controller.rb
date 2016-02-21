class TracksController < ApplicationController
  before_action :set_track, only: [:show, :edit, :update, :destroy]
  

  # GET /tracks
  # GET /tracks.json
  def index
    @tracks = Track.all
  end

  # GET /tracks/1
  # GET /tracks/1.json
  def show
      request = HTTParty.get("https://api.github.com/repos/weareci/#{@track.github_repo_url}/readme", :headers => {"User-Agent" => "weareci", "Accept" => "application/vnd.github.VERSION.html+json"})
      @readme = request.parsed_response
  end
  

  # GET /tracks/new
  def new
    @track = Track.new
    unit= @track.units.build
    unit.lessons.build
  end

  # GET /tracks/1/edit
  def edit
  end

  # POST /tracks
  # POST /tracks.json
  def create
    @track = Track.new(track_params)

    respond_to do |format|
      if @track.save
        format.html { redirect_to @track, notice: 'Track was successfully created.' }
        format.json { render :show, status: :created, location: @track }
      else
        format.html { render :new }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tracks/1
  # PATCH/PUT /tracks/1.json
  def update
    respond_to do |format|
      if @track.update(track_params)
        format.html { redirect_to @track, notice: 'Track was successfully updated.' }
        format.json { render :show, status: :ok, location: @track }
      else
        format.html { render :edit }
        format.json { render json: @track.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tracks/1
  # DELETE /tracks/1.json
  def destroy
    @track.destroy
    respond_to do |format|
      format.html { redirect_to tracks_url, notice: 'Track was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_track
      @track = Track.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def track_params
        params.require(:track).permit(:name, :github_repo_url, unit_attributes: [:name, :track_id, lesson_attributes:[:name, :tracks, :unit_id]])
    end
end
