class ContactsController < ApplicationController
  def create
    # params[:student_id]
    @student = Student.find(params[:student_id])
    contact = @student.contacts.new
    contact.requested_at = Time.now

    if contact.save
      # Update cache counter for ordering students in application#index
      @student.update_attributes(last_requested_help_at: contact.requested_at)

      redirect_to @student
    end
  end

  def update
    # params[:student_id, :id]
    @student = Student.find(params[:student_id])
    contact = Contact.find(params[:id])
    contact.completed_at = Time.now

    if contact.save
      redirect_to @student
    end
  end
end
