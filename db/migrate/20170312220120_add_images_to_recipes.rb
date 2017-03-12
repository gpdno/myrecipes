class AddImagesToRecipes < ActiveRecord::Migration[5.0]
  def change
    add_column :recipes, :recipeimage, :text
  end
end
