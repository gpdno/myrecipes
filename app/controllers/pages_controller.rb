class PagesController < ApplicationController

  def home
    #redirect_to recipes_path if logged_in?
    #@recipes = Recipe.all
    @recipe = Recipe.all.sort_by{|likes| likes.thumbs_up_sum}.reverse
  end

  def terms
    @title = "Terms & Conditions"
  end
   
 def privacy
    @title = "Privacy Policy"
  end
  
end