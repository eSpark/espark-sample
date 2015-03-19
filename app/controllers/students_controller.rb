class StudentsController < ApplicationController
  layout "student"

  def show
    @student = Student.find(params[:id])
  end

end
