class AddActionedAtToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :actioned_at, :datetime
  end
end
