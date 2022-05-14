require "csv"
require_relative "../models/meal"

class MealRepository
  def initialize(csv_path)
    @csv_path = csv_path
    @meals = []
    @next_id = 1
    load_csv # after loading, the next id should be 6 (5 meals in initial CSV)
  end

  def all
    @meals
  end

  def create(meal)
    # meal doesn't have an id yet!
    # 1. define an id for the meal
    meal.id = @next_id
    @next_id += 1
    # 2. store the meal into @meals
    @meals << meal
    # 3. save all the meals into the CSV file
    save_csv
  end

  def save_csv
    CSV.open(@csv_path, "wb") do |csv|
      csv << ["id", "name", "price"]
      @meals.each do |meal|
        csv << [meal.id, meal.name, meal.price]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_path, headers: :first_row, header_converters: :symbol) do |row|
      # row => {id: "1", name: "Margherita", price: "8" }
      row[:id] = row[:id].to_i
      row[:price] = row[:price].to_i
      @meals << Meal.new(row)
    end
    # update the @next_id value
    # unless @meals.empty?
    #   last_meal = @meals.last
    #   @next_id = last_meal.id + 1
    # end
    # @next_id = @meals.empty? ? 1 : @meals.last.id + 1
    @next_id = @meals.last.id + 1 if @meals.any?
  end
end