class StatusesController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update]

  respond_to :html, :js

  # GET /statuses
  # GET /statuses.json
  def index
    @statuses = Status.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statuses }
    end
  end

  # GET /statuses/1
  # GET /statuses/1.json
  def show
   
    @status = Status.find(params[:id])
    @likes = @status.likers(User)   
   
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @status }
            #format.js
    end
  end

  # GET /statuses/new
  # GET /statuses/new.json
  def new
    @status = Status.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @status }
    end
  end

  # GET /statuses/1/edit
  def edit
    @status = Status.find(params[:id])
  end

  # POST /statuses
  # POST /statuses.json
  def create
    @status = Status.new(params[:status])
    @status.user=current_user
    respond_to do |format|
      if @status.save
        format.html { redirect_to @status, notice: 'Photo was successfully uploaded.' }
        format.json { render json: @status, status: :created, location: @status }
      else
        format.html { render action: "new" }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /statuses/1
  # PUT /statuses/1.json
  def update
    @status = Status.find(params[:id])

    respond_to do |format|
      if @status.update_attributes(params[:status])
        format.html { redirect_to @status, notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    @status = Status.find(params[:id])
    @status.destroy

    respond_to do |format|
      format.html { redirect_to statuses_url }
      format.json { head :no_content }
    end
  
end


     def addrate
    @rating = Rating.new 
    @rating_value =  params[:rating_value]
    @status_id = params[:status_id]
    @rating.rating_value = @rating_value
    @rating.status_id = @status_id
    @rating.user = current_user
    @rating.save
    @StatusRow = Status.where(:id => @rating.status_id)
    @RatingCountValue = ""

    @RatingCountValue = @StatusRow.select(:rating_count).map(&:rating_count)[0]

    if (@RatingCountValue == nil)

      @StatusRow.each do |rate| 

       rate[:ratings] = @rating.rating_value

       rate.rating_count = 1
       rate.save

     end

      else
        @RatingAllValues = @StatusRow.select(:ratings).map(&:ratings)[0]
        @StatusRow.each do |rate| 
          rate[:ratings] = rate[:ratings] + @rating.rating_value
          rate[:rating_count] = rate[:rating_count] + 1
          rate.save

        end
          

      end

       @AllRating = Status.where(:id => @status_id)
    @RatingCount = @AllRating.count
   # @AllRatingSum = 0
      @AllRating.each do |rate|
        @AllRatingSum = @AllRatingSum + rate[:ratings].to_i
        @RatingCount = @RatingCount + rate[:rating_count].to_i


      end
    @RatedAll = Rating.where(:user_id => current_user.id, :status_id => @status_id)
    @Rated = @RatedAll.count

       respond_to do |format|
        format.js
    end
    


  end

def updaterate
      @rating_value =  params[:rating_value]
      @rating_value = @rating_value.to_f
      @status_id = params[:status_id]
      @status_id = @status_id.to_i
      @RatingRow = Rating.where(:status_id => @status_id, :user_id => current_user.id)
      
      @RatingRow.each do |update|

          @oldrate = update[:rating_value] 
          update[:rating_value] =  @rating_value     
          update.save

        end
        @StatusRow = Status.where(:id => @status_id)
        @RatingAllValues = @StatusRow.select(:ratings).map(&:ratings)[0]
        @StatusRow.each do |rate|
          rate[:ratings] = rate[:ratings] - @oldrate 
          rate[:ratings] = rate[:ratings] + @rating_value
          rate.save
          @AllRatingSum = rate[:ratings];
          @RatingCount = rate[:rating_count];

        end

        respond_to do |format|
      format.js
    end


  end


   def totalrates
    @status = Status.find(params[:id])
    @AllRates = Rating.where(:status_id => @status.id)

   end

  def like
    @status = Status.find(params[:id])
    current_user.like!(@status)
    @status.save
    #if the status.save
#     flash[:notice] = 'Photo was successfully liked.'
    redirect_to :controller =>'statuses', :action => 'show', :id => @status.id
  # else
   #  render new with the errors
   #end

      end

def rate
  rating_value =  params[:rating_value].to_i
  @status_id = params[:status_id]
  @status = Status.find(@status_id)
  old_rating = Rating.where(:status_id => @status_id , :user_id => current_user.id).first
  unless old_rating.nil?
    @status.rating_sum = @status.rating_sum - old_rating.rating_value
    old_rating.rating_value = rating_value
    old_rating.save
    @status.rating_sum = @status.rating_sum + old_rating.rating_value
    @status.save
  else    
    rating = Rating.new
    rating.user = current_user
    rating.status = @status
    rating.rating_value = rating_value
    rating.save
    @status.rating_count = @status.rating_count+1
    @status.rating_sum = @status.rating_sum + rating_value
    @status.save
  end
   respond_to do |format|
        format.js
    end
 end





end
