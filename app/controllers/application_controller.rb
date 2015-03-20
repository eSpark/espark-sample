class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    # Students ordered by when they last needed help
    @students = Student.all.order("last_requested_help_at DESC")
    @new_requests_count = Contact.where("completed_at IS NULL").count
  end
end
