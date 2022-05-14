class MealsView
  def display(meals)
    meals.each_with_index do |meal, index|
      puts "#{index + 1} - #{meal.name} | #{meal.price}¥"
    end
  end

  def ask_for(something)
    puts "#{something.capitalize}下さい！"
    gets.chomp
  end
end