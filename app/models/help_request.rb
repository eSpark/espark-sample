class HelpRequest < ActiveRecord::Base
  belongs_to :student

  def self.any_active?
    !!HelpRequest.where(active: true).first
  end
end
