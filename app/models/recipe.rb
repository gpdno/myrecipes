class Recipe < ApplicationRecord

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 5, maximum: 500 }
  validates :chef_id, presence: true

  belongs_to :chef
  default_scope -> { order(name: :asc)}
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def thumbs_up_sum
    self.likes.where(like: true).size
  end
  
  def thumbs_down_sum
    self.likes.where(like: false).size    
  end

end
