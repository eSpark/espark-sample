require "rails_helper"

describe "request help" do

  before(:each) do
    @student = FactoryGirl.create(:student)
  end

  describe "student show page" do

    it "should display correct text" do
      visit student_path(@student.id)
      expect(page).to have_selector("h1", text: "Welcome, #{@student.name}")
    end

  end

end

# student view should have "Request Help From My Teacher" button
# when student clicks button
  # button disappears
  # indicator saying teacher has been notified appears

# teacher view
  # if no students have requested help
    # no alert that students have requested help
  # if any students have requested help
    # alert shows students who have requested help in the past day,
      # along with time help was requested,
      # along with option to clear help request for that student
    # TODO: how to deal with requests that last longer than a day without being cleared?

# when teacher clears help request (after talking to student)
  # student disappears from teacher dashboard alert
  # button to request help shows up again for student
