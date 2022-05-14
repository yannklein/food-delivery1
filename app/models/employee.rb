class Employee
  attr_reader :username, :password, :role
  attr_accessor :id
  def initialize(attributes = {})
    @id = attributes[:id]
    @username = attributes[:username]
    @password = attributes[:password]
    @role = attributes[:role]
  end

  # def role 
  #   @role
  # end

  def rider?
    role == "rider"
  end

  def manager?
    !rider?
  end
end