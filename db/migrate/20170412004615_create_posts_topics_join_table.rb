class CreatePostsTopicsJoinTable < ActiveRecord::Migration[5.0]
  def change
    create_join_table :posts, :topics do |t|
      t.index :post_id
      t.index :topic_id
    end
  end
end
