class Student < ActiveRecord::Base
  has_many :contacts

  def requested_help?
    contacts.where('completed_at IS NULL').any?
  end
end
