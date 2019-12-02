class RemoveActionedAtFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :actioned_at, :datetime
  end
end
