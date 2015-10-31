class ProfilesController < ApplicationController
  def show
     @user = User.find_by_profile_name(params[:id])
    
     render action: :show
     
     render file: 'public/404', status: 404, formats: [:html]
    
  end
end
