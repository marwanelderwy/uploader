class RenameRatingsToRatingSum < ActiveRecord::Migration
  def up
  	rename_column :statuses, :ratings, :rating_sum
  end

  def down
  end
end
