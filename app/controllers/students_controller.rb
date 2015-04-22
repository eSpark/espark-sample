class StudentsController < ApplicationController
  layout "student"

  def show
    @student = Student.find(params[:id])
    @has_math_request = @student.help_requests.where(subject: "Math").count > 0
    @has_english_request = @student.help_requests.where(subject: "English").count > 0
  end

  def ask_for_help
    request = HelpRequest.new(student_id: params[:id], subject: params[:subject])
    if request.save
      render json: {created: true}, status: 200
    else
      render json: {error: true}, status: 422
    end
  end
end
