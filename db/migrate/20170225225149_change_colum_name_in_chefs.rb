class ChangeColumNameInChefs < ActiveRecord::Migration[5.0]
  def change
    rename_column :chefs, :name, :chefname
  end
end
