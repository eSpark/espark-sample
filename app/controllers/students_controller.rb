class StudentsController < ApplicationController
  layout "student"

  def show
    @student = Student.find(params[:id])
    @help_request = HelpRequest.new
  end

end
