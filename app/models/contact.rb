class Contact < ActiveRecord::Base
  belongs_to :student

  def formated_requested_at
    requested_at.strftime("%b %e - %l:%M%P")
  end
end
