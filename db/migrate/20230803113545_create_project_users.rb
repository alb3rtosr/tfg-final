class CreateProjectUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :project_users do |t|
      t.integer :project_id
      t.integer :user_id
      t.integer :role

      t.timestamps
    end

    add_foreign_key :project_users, :projects, column: :project_id
    add_foreign_key :project_users, :users, column: :user_id
  end
end
