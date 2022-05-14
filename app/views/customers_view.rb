class CustomersView
  def display(customers)
    customers.each_with_index do |customer, index|
      puts "#{index + 1} - #{customer.name} from #{customer.address}"
    end
  end

  def ask_for(something)
    puts "#{something.capitalize}下さい！"
    gets.chomp
  end
end