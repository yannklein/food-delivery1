class Router
  def initialize(meals_controller, customers_controller, sessions_controller)
    @running = true
    @meals_controller = meals_controller
    @customers_controller = customers_controller
    @sessions_controller = sessions_controller
    @current_user = nil
  end

  def run
    while @running
      @current_user = @sessions_controller.login if @current_user.nil?
      @current_user.manager? ? manager_menu : rider_menu
    end
  end

  private

  def manager_menu
    print_manager_menu
    choice = gets.chomp.to_i
    print `clear`
    route_manager_action(choice)
  end

  def rider_menu
    print_rider_menu
    choice = gets.chomp.to_i
    print `clear`
    route_rider_action(choice)
  end

  def print_manager_menu
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. Add new meal"
    puts "2. List all meals"
    puts "3. Add new customer"
    puts "4. List all customers"
    puts "7. Logout"
    puts "8. Exit"
    print "> "
  end

  def route_manager_action(choice)
    case choice
      when 1 then @meals_controller.add
      when 2 then @meals_controller.list
      when 3 then @customers_controller.add
      when 4 then @customers_controller.list
      when 7 then @current_user = nil
      when 8 then stop!
    end
  end

  def print_rider_menu
    puts "--------------------"
    puts "------- MENU -------"
    puts "--------------------"
    puts "1. List all meals"
    puts "2. List all customers"
    puts "7. Logout"
    puts "8. Exit"
    print "> "
  end

  def route_rider_action(choice)
    case choice
      when 1 then @meals_controller.list
      when 2 then @customers_controller.list
      when 7 then @current_user = nil
      when 8 then stop!
    end
  end

  def stop!
    @running = false
  end
end
