require 'rails_helper'

RSpec.describe Student, type: :model do
  let(:student) {Student.create(name: 'Grace', grade_level: 4)}

  context '#active_help_request' do
    it 'returns the active help request' do
      help_request = student.help_requests.create(active: true)
      expect(student.active_help_request).to eq help_request
    end

    it 'returns nil if inactive help request' do
      help_request = student.help_requests.create(active: false)
      expect(student.active_help_request).to eq nil
    end

    it 'returns nil if no help requests' do
      expect(student.active_help_request).to eq nil
    end
  end
end
