class Comments < ActiveRecord::Migration
   def change
    create_table(:comments) do |t|
      t.string :comment
      t.integer :avatar_id
      t.integer :user_id
end
end
  def up

  end

  def down
  end
end
