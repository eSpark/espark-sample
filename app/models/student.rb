class Student < ActiveRecord::Base
  has_many :help_requests

  def active_help_request
    self.help_requests.where(active: true).first
  end
end
