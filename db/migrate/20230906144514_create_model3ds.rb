class CreateModel3ds < ActiveRecord::Migration[7.0]
  def change
    create_table :model3ds do |t|
      t.string :description
      t.references :user, null: false, foreign_key: true
      t.integer :makes, default: 1

      t.timestamps
    end
  end
end
