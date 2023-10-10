class AddDescriptionToTopics < ActiveRecord::Migration[7.0]
  def change
    add_column :topics, :description, :string
  end
end
