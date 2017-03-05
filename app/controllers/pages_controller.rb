class PagesController < ApplicationController

  def home
    #redirect_to recipes_path if logged_in?
    @recipes = Recipe.all
  end

  def terms
    @title = "Terms & Conditions"
  end
   
 def privacy
    @title = "Privacy Policy"
  end
  
end