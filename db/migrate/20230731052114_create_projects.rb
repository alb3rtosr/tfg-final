class CreateProjects < ActiveRecord::Migration[7.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :description
      t.string :state
      t.string :visibility
      t.boolean :accepted, default: false
      
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
