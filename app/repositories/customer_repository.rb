require "csv"
require_relative "../models/customer"

class CustomerRepository
  def initialize(csv_path)
    @csv_path = csv_path
    @customers = []
    @next_id = 1
    load_csv # after loading, the next id should be 6 (5 customers in initial CSV)
  end

  def all
    @customers
  end

  def create(customer)
    # customer doesn't have an id yet!
    # 1. define an id for the customer
    customer.id = @next_id
    @next_id += 1
    # 2. store the customer into @customers
    @customers << customer
    # 3. save all the customers into the CSV file
    save_csv
  end

  def save_csv
    CSV.open(@csv_path, "wb") do |csv|
      csv << ["id", "name", "address"]
      @customers.each do |customer|
        csv << [customer.id, customer.name, customer.address]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_path, headers: :first_row, header_converters: :symbol) do |row|
      # row => {id: "1", name: "Margherita", address: "8" }
      row[:id] = row[:id].to_i
      row[:address] = row[:address]
      @customers << Customer.new(row)
    end
    # update the @next_id value
    # unless @customers.empty?
    #   last_customer = @customers.last
    #   @next_id = last_customer.id + 1
    # end
    # @next_id = @customers.empty? ? 1 : @customers.last.id + 1
    @next_id = @customers.last.id + 1 if @customers.any?
  end
end