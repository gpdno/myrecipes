class Ingredient < ApplicationRecord

  validates :name, presence: true, length: { minimum: 3, maximim: 25}
  validates_uniqueness_of :name
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients, dependent: :destroy

end