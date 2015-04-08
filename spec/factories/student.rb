FactoryGirl.define do
  factory :student do
    sequence(:name) { |n| "Student#{n}" }

    factory :student_requesting_help do
      help_request_state true
      help_last_requested Time.current
    end

  end
end
