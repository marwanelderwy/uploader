class ChangeDefaultRatings < ActiveRecord::Migration
  def up
  	change_column :statuses, :rating_sum , :integer , :default => 0
  	change_column :statuses, :rating_count , :integer , :default => 0
  end

  def down
  end
end
