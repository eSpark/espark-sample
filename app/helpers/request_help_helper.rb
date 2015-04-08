module RequestHelpHelper
  def help_request_status_display
    # adding button for student to clear own help request though wasn't explicitly required
      # student could easily answer their own question before teacher gets to them
    if @student.help_request_state
      content_tag(:p, "Your teacher has been notified of your request for help.", class: "help teacher-notified") +
      link_to("Clear Help Request", student_clear_help_request_path(@student), class: "btn btn-default student-clear")
    else
      link_to "Request Help From My Teacher", student_request_help_path(@student), class: "btn btn-primary help request-help"
    end
  end

  # TODO: get clarification: should this list only include students who have requested help within the past day?
    # instructions say something along those lines, but it seems better to just include all students where help_request_state is true
    # maybe teacher never got to a certain student the day before, in which case student should still appear on teacher's list
  def students_need_help_list
    @students.select { |s| s.help_request_state }
  end

  def display_time(datetime)
    datetime.strftime("%-l:%M%P (%-m/%-d/%y)")
  end
end
