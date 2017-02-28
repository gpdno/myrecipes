require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  
  def setup
    @chef = Chef.create!(chefname: "Gregory", email: "greg@example.com")
    @recipe = Recipe.create(name: "Tomato Soup", description: "A very tasty soup", chef: @chef)
    @recipe2 = @chef.recipes.build(name: "Chef Salad", description: "Lettus have green stuff")
    @recipe2.save
  end

  test "should get recipes index" do
    get recipes_url
    assert_response :success
  end

  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_select "a[href=?]", recipe_path(@recipe), text: @recipe.name
    assert_select "a[href=?]", recipe_path(@recipe2), text: @recipe2.name
  end

  test "should get recipes show" do
    get recipe_path(@recipe)
    assert_template 'recipes/show'
    #assert_match @recipe.name, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.chefname, response.body
  end

  test "create ne vaild recipe" do
    get new_recipe_path

  end

  test "reject invalid recipe" do
    get new_recipe_path

  end
end
