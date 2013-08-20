class FollowsController < ApplicationController


def show
  @status = Status.find(params[:id])
  @user  = current_user
  #@status_id = params[:status_id]
  #@status = Status.find(@status_id)
  @celebrity_id = @status.user_id
  @celebrity = User.find(@celebrity_id)
  
   if @celebrity.followed_by?(@user)
    @user.unfollow!(@celebrity)

  else 
    @user.follow!(@celebrity)
  end
  redirect_to :controller =>'statuses', :action => 'show', :id => @status.id
	

	#respond_to do |format|
   # format.js
     #     end

end

end