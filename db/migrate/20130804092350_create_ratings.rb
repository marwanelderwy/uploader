class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :rating_value

      t.timestamps
    end

      add_column :ratings, :user_id, :integer
      add_index :ratings, :user_id
      add_column :ratings, :status_id, :integer
      add_index :ratings, :status_id
  end
end