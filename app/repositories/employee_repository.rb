require "csv"
require_relative "../models/employee"

class EmployeeRepository
  def initialize(csv_path)
    @csv_path = csv_path
    @employees = []
    @next_id = 1
    load_csv # after loading, the next id should be 6 (5 employees in initial CSV)
  end

  def all
    @employees
  end

  def find_by_username(username)
    @employees.find { |employee| employee.username == username}
  end

  def create(employee)
    # employee doesn't have an id yet!
    # 1. define an id for the employee
    employee.id = @next_id
    @next_id += 1
    # 2. store the employee into @employees
    @employees << employee
    # 3. save all the employees into the CSV file
    save_csv
  end

  def save_csv
    CSV.open(@csv_path, "wb") do |csv|
      csv << ["id", "username", "password", "role"]
      @employees.each do |employee|
        csv << [employee.id, employee.username, employee.password, employee.role]
      end
    end
  end

  def load_csv
    CSV.foreach(@csv_path, headers: :first_row, header_converters: :symbol) do |row|
      # row => {id: "1", username: "Margherita", password: "8" }
      row[:id] = row[:id].to_i
      @employees << Employee.new(row)
    end
    # update the @next_id value
    # unless @employees.empty?
    #   last_employee = @employees.last
    #   @next_id = last_employee.id + 1
    # end
    # @next_id = @employees.empty? ? 1 : @employees.last.id + 1
    @next_id = @employees.last.id + 1 if @employees.any?
  end
end