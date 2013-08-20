module StatusesHelper



   def return_ID(integer)
      @@stringg = ""
      @@Final_String = ""
      @@Real_ID = integer.to_s
    @@stringg = "http://localhost:3000/statuses/" + @@Real_ID
    @@Final_String = URI::escape(@@stringg)
    return @@Final_String
  end


def rating_ballot
    if @rating = current_user.ratings.find_by_status_id(params[:id])
        @rating
    else
        current_user.ratings.new
    end
end




def current_user_rating
    if @rating = current_user.ratings.find_by_status_id(params[:id])
        @rating.value
    else
        "N/A"
    end
end



end
