class AddPublicToModel3ds < ActiveRecord::Migration[7.0]
  def change
    add_column :model3ds, :public, :boolean, default: false
  end
end
