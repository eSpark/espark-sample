class StudentsController < ApplicationController
  layout "student"

  def show
    @student = Student.find(params[:id])
  end

  def request_help
    @student = Student.find(params[:student_id])
    @student.help_request_state = true
    @student.help_last_requested = Time.current
    @student.save
    redirect_to :back, notice: "Help requested!"
  end

end
