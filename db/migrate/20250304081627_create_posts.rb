class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.text :body
      t.string :shop_name
     

      t.timestamps
    end
  end
end
