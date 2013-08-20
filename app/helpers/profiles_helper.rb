module ProfilesHelper


   def return_user_ID(integer)
      @@stringg = ""
      @@Final_String = ""
      @@Real_ID = integer.to_s
    @@stringg = "http://localhost:3000/" + @@Real_ID
    @@Final_String = URI::escape(@@stringg)
    return @@Final_String
  end





end
