class AddLikertReview < ActiveRecord::Migration[7.0]
  def change
    add_column :reviews, :likert, :integer
    add_column :users, :rating, :float
    remove_reference :reviews, :post
  end
end