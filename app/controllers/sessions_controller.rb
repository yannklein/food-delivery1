require_relative "../views/sessions_view"

class SessionsController
  def initialize(employee_repository)
    @employee_repository = employee_repository
    @sessions_view = SessionsView.new
  end

  def login
    # ask username (via the view)
    username = @sessions_view.ask_for("username")
    # ask pwd (via the view)
    password = @sessions_view.ask_for("password")
    # check in repo if it exist, it is valid
    employee = @employee_repository.find_by_username(username)
    # if not, wrong password
    if employee.nil? || employee.password != password
      @sessions_view.wrong_pwd
      return login
    end
    # if yes, return the employee instance 
    employee
  end
end