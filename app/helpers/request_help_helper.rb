module RequestHelpHelper
  def help_request_status_display
    if @student.help_request_state
      content_tag :p, "Your teacher has been notified of your request for help.", class: "help teacher-notified"
    else
      link_to "Request Help From My Teacher", student_request_help_path(@student), class: "btn btn-primary help request-help"
    end
  end
end
