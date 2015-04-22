class Student < ActiveRecord::Base
  has_many :help_requests
end
