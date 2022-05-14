require_relative "../views/customers_view"
require_relative "../models/customer"

class CustomersController
  def initialize(customer_repository)
    @customer_repository = customer_repository
    @customers_view = CustomersView.new
  end

  def list
    # get the customers from the repo (all)
    customers = @customer_repository.all
    # give the customers to the view for display
    @customers_view.display(customers)
  end

  def add
    # make the view ask the user for a name and a address
    name = @customers_view.ask_for("name")
    address = @customers_view.ask_for("address")
    # create a new customer instance
    customer = Customer.new(name: name, address: address)
    # ask the repo to store the customer
    @customer_repository.create(customer)
  end
end