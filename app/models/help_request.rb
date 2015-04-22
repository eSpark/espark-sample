class HelpRequest < ActiveRecord::Base
  belongs_to :student

  validates :subject, inclusion: {in: ["Math", "English"]}
end
