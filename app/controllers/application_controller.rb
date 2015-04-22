class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
    @students = Student.all
  end

  def respond_to_help
    student = Student.find(params[:student_id])
    help_request = HelpRequest.find(params[:help_request_id])
    if help_request
      help_request.destroy
      flash[:help_request_result] = "Thanks for helping student #{params[:student_id]}!"
      redirect_to action: :index
    end
  end
end
