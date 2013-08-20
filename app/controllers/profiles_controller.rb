class ProfilesController < ApplicationController
  def show
    @user = User.find(params[:id])
    @total_followers = @user.followers(User).count
    if @user
      @statuses = @user.statuses.all
      render action: :show
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end


  def find_profile
    @profile = params[:type] ? Profile.find(params[:id]) : current_profile
  end

  
end
