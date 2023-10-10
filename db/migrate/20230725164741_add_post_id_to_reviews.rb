class AddPostIdToReviews < ActiveRecord::Migration[7.0]
  def change
    add_column :reviews, :post_id, :integer
  end
end
