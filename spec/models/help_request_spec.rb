require 'rails_helper'

RSpec.describe HelpRequest, type: :model do

  context 'active_help_requests?' do
    it 'returns true if there are active help requests' do
      help_request = HelpRequest.create(active: true)
      expect(HelpRequest.any_active?).to eq true
    end

    it 'returns false if there are no active help requests' do
      expect(HelpRequest.any_active?).to eq false
    end

    it 'returns false if there are inactive help requests' do
      help_request = HelpRequest.create(active: false)
      expect(HelpRequest.any_active?).to eq false
    end
  end
end
