require_relative "../views/meals_view"
require_relative "../models/meal"

class MealsController
  def initialize(meal_repository)
    @meal_repository = meal_repository
    @meals_view = MealsView.new
  end

  def list
    # get the meals from the repo (all)
    meals = @meal_repository.all
    # give the meals to the view for display
    @meals_view.display(meals)
  end

  def add
    # make the view ask the user for a name and a price
    name = @meals_view.ask_for("name")
    price = @meals_view.ask_for("price").to_i
    # create a new meal instance
    meal = Meal.new(name: name, price: price)
    # ask the repo to store the meal
    @meal_repository.create(meal)
  end
end