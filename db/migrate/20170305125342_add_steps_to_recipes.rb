class AddStepsToRecipes < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :steps, :text
  end
end
