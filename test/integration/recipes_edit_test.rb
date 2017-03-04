require 'test_helper'

class RecipesEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "mashrur", email: "mashrur@example.com",
                          password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "john", email: "john@example.com",
                        password: "password", password_confirmation: "password")
    @recipe = Recipe.create(name: "Tomato Soup", description: "A very tasty soup", chef: @chef)
  end

  test "reject invalid recipe update" do
    sign_in_as(@chef, "password")
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    patch recipe_path(@recipe), params: { recipe: { name: " ", description: " "}}
    assert_template 'recipes/edit'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
    
  end

  test "successfuly edit recipe update" do
    sign_in_as(@chef, "password")
    get edit_recipe_path(@recipe)
    assert_template 'recipes/edit'
    updated_name = "Updated recipe name"
    updated_description = "Updated recipe description"
    patch recipe_path(@recipe), params: { recipe: { name: updated_name, description: updated_description}}
    assert_redirected_to @recipe
    assert_not flash.empty?
    @recipe.reload
    assert_match updated_name, @recipe.name
    assert_match updated_description, @recipe.description
  end

end
