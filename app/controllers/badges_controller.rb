class BadgesController < ApplicationController
    before_action :set_badge, only: [:show, :edit, :update, :destroy], :credly_authenticate

  # GET /badges
  # GET /badges.json
  def index
    @badges = Badge.all
  end

  # GET /badges/1
  # GET /badges/1.json
  def show
  end

  #POST
  def issue
      
  end

  # POST /badges
  # POST /badges.json
  def create
    @badge = Badge.new(badge_params)

    respond_to do |format|
      if @badge.save
        format.html { redirect_to @badge, notice: 'Badge was successfully created.' }
        format.json { render :show, status: :created, location: @badge }
      else
        format.html { render :new }
        format.json { render json: @badge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /badges/1
  # PATCH/PUT /badges/1.json
  def update
    respond_to do |format|
      if @badge.update(badge_params)
        format.html { redirect_to @badge, notice: 'Badge was successfully updated.' }
        format.json { render :show, status: :ok, location: @badge }
      else
        format.html { render :edit }
        format.json { render json: @badge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /badges/1
  # DELETE /badges/1.json
  def destroy
    @badge.destroy
    respond_to do |format|
      format.html { redirect_to badges_url, notice: 'Badge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_badge
      @badge = Badge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def badge_params
      params[:badge]
    end
    
    def credly_authenticate
        response = HTTParty.post("https://api.credly.com/v1.1/authenticate?access_token=dbd3cb19ee7c5fff3626b1be51dfef3c1c41fe73b624ff090e9d3b33c16db75530651552986b4897384c99f69a53bcea1fd2524daf8796d57bbab31869b5baa6",
                                 :headers => { "X-Api-Key" => "03e428bf4d97a3ee22eecc2d61d520e6",
                                 "X-Api-Secret" => "DcnuBwELqo7r5xZf5wwgY/KSiKy+qjAZ3vUmqurBOx6lO4pOIHg1idwIFJqOy9tn+lxa0S8zKpjZdFdIP7DSSbrp/0G1GRnaNaCAb+h/8E2Um5hLSjwzE4eEYIrAgGwMJUjDsJxhyCXh0Eg/yan3Z1+A2stHrMrGRC/lIh3PK5M="
                                 },
                                 basic_auth: { username: "pwjablonski@gmail.com", password: "56a79f018a2cc" }
        )
        @token = response["data"]["token"]
    end

    
    
end
