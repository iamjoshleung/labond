class RemoveTopicIdFromPosts < ActiveRecord::Migration[5.0]
  def change
    remove_reference :posts, :topic, index: true, foreign_key: true
  end
end
