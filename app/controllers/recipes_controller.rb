class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy, :like]
  before_action :require_user, except: [:index, :show, :like]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  before_action :require_like_login, only: [:like]

  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 5)
    @recipes_likes = Recipe.all.sort_by{|likes| likes.thumbs_up_sum}.reverse.paginate(page: params[:page], per_page: 5)
  end

  def show
    @comment = Comment.new
    @comments = @recipe.comments.paginate(page: params[:page], per_page: 5)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.chef = current_chef
    if @recipe.save
      flash[:success] = "Your recipe was successfully created"
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end 
  end

  def edit
  end

  def update
    if @recipe.update(recipe_params)
      flash[:success] = "Your recipe was successfully edited"
      redirect_to recipe_path(@recipe)
    else
      render 'edit'
    end
  end

  def destroy
    Recipe.find(params[:id]).destroy
    flash[:success] = "The recipe was successfully deleted"
    redirect_to recipes_path
  end

  def like
    like = Like.create(like: params[:like], chef: current_chef, recipe: @recipe)
    if like.valid?
      flash[:success] = "Your choice was succesful"
      redirect_to :back
    else
      flash[:danger] = "You can only like/dislike a recipe once"
      redirect_to :back
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :steps, ingredient_ids: [])
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def require_same_user
    if current_chef != @recipe.chef and !current_chef.admin?
      flash[:danger] = "You must be logged in as that user"
      redirect_to recipes_path
    end
  end

  def require_like_login
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to :back
    end
  end
end