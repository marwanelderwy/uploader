class ApplicationController < ActionController::Base
  protect_from_forgery

  def index
    @users = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statuses }
    end
end
end
