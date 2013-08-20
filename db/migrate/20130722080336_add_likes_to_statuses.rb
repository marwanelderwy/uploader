class AddLikesToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :likes, :integer
  end
end
