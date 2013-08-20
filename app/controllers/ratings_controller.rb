class RatingsController < ApplicationController
  # GET /ratings
  # GET /ratings.json

    before_filter :auth_user

  def auth_user
    redirect_to new_user_session_url unless user_signed_in?
  end

  
  def index
    @ratings = Rating.all
     @StatusRow = Status.where(:status_id => 1)
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ratings }
    end
  end

  # GET /ratings/1
  # GET /ratings/1.json
  def show
    @rating = Rating.find(params[:id])

   

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rating }
    end
  end

  # GET /ratings/new
  # GET /ratings/new.json



  def new
    @rating = Rating.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rating }
    end
  end

  # GET /ratings/1/edit
  def edit
    @rating = Rating.find(params[:id])
  end

  # POST /ratings
  # POST /ratings.json
  def create
    @rating = Rating.new(params[:rating])

     @rating.user = current_user


     @StatusRow = Status.where(:id => @rating.status_id)

     @RatingCountValue = ""

    @RatingCountValue = @StatusRow.select(:rating_count).map(&:rating_count)[0]

    if (@RatingCountValue == NULL )

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


 

    respond_to do |format|
      if @rating.save
        format.html { redirect_to "/statuses/" + @rating.status_id.to_s}
        format.js
        format.json { render json: @rating, status: :created, location: @rating }
      else
        format.html { render action: "new" }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ratings/1
  # PATCH/PUT /ratings/1.json
  def update
    @rating = Rating.find(params[:id])

    respond_to do |format|
      if @rating.update_attributes(rating_params)
        format.html { redirect_to @rating, notice: 'Rating was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ratings/1
  # DELETE /ratings/1.json
  def destroy
    @rating = Rating.find(params[:id])
    @rating.destroy

    respond_to do |format|
      format.html { redirect_to ratings_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def rating_params
      params.require(:rating).permit(:rating)
    end
    
end