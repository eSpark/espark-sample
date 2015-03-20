class HelpRequestsController < ApplicationController

  def create
    # debugger
    @student = Student.find(params[:help_request][:student_id])
    @help_request = HelpRequest.create(student_id: @student.id, active: true)
    redirect_to student_path(@student)
  end

end
