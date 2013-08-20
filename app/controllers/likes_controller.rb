class LikesController < ApplicationController
  before_filter :authenticate_user!
  respond_to :js, :html
	def show
    @status = Status.find(params[:id])
    current_user.like!(@status)
    @AllCounts = @status.likers(User).count
   	@status.save
   	#if the status.save
#   	flash[:notice] = 'Photo was successfully liked.'
   # redirect_to :controller =>'statuses', :action => 'show', :id => @status.id
  # else
   #  render new with the errors
   #end
  


   respond_to do |format|
    format.js
          end
   	  



      end

end
