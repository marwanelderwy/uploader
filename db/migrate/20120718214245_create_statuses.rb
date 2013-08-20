class CreateStatuses < ActiveRecord::Migration
  def change
    create_table :statuses do |t|
      t.string :name
      t.text :content
      t.integer :rating_count
    	t.float :ratings
      t.timestamps
    end
  end
end
