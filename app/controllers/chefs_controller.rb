class ChefsController < ApplicationController

  def new
    @chef = Chef.new
  end

  def create
    @chef = Chef.new(chef_params)
    if @chef.save
      flash[:success] = "Welcome #{@chef.chefname} to Our Family Recipes"
      redirect_to chef_path(@chef)
    else
      render 'new'
    end
  end

  def show

  end

  def chef_params
    params.require(:chef).permit(:chefname, :email, :password, :password_comformation)
  end

end