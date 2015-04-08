require "rails_helper"

describe "request help" do

  before(:each) do
    @student = FactoryGirl.create(:student)
  end

  describe "student show page" do

    it "should display correct text" do
      visit student_path(@student.id)
      expect(page).to have_selector("h1", text: "Welcome, #{@student.name}")
      expect(page).to have_selector("a.request-help", text: "Request Help From My Teacher")
    end

  end

  describe "clicking request help button" do

    before(:each) do
      allow(Student).to receive(:find).and_return(@student)
      visit student_path(@student.id)
      click_link("Request Help From My Teacher")
    end

    it "should change student help request state and time in database" do
      expect(@student.help_request_state).to eq(true)
      expect(@student.help_last_requested).to be_within(5.seconds).of(Time.current)
    end

    it "should hide request help button and display teacher notified message on student page" do
      expect(page).to have_selector("p.teacher-notified", text: "Your teacher has been notified of your request for help.")
      expect(page).to_not have_text("Request Help From My Teacher")
      expect(page).to have_selector("div.alert-success", text: "Help requested!")
    end

    it "should show student help request on teacher page" do
      visit root_path
      expect(page).to have_text("#{@student.name}")
    end

  end

  describe "teacher dashboard page" do

    describe "no students have requested help" do

      it "should display no student help info" do
        visit root_path
        expect(page).to_not have_selector("h3", text: "The following students have requested help:")
      end

    end

    describe "students have requested help" do

      before(:each) do
        @students = FactoryGirl.create_list(:student_requesting_help, 3)
      end

      it "should display student help info" do
        visit root_path
        expect(page).to have_selector("h3", text: "The following students have requested help:")
        within(".students-help-list") do
          expect(all("tr")[1].all("td")[0].text).to eq(@students[0].name)
          expect(all("tr")[2].all("td")[0].text).to eq(@students[1].name)
          expect(all("tr")[3].all("td")[0].text).to eq(@students[2].name)
        end

      end

      describe "clearing help requests" do

        before(:each) do
          visit root_path
          within(".students-help-list") do
            within(all("tr")[1]) do
              click_link("Clear Help Request")
            end
            within(all("tr")[3]) do
              click_link("Clear Help Request")
            end
          end
        end

        it "should change help request statuses in database" do
          @students.each { |s| s.reload }
          expect(@students[0].help_request_state).to eq(false)
          expect(@students[1].help_request_state).to eq(true) # no change
          expect(@students[2].help_request_state).to eq(false)
        end

        it "should change display info on screen" do
          expect(page).to have_selector("div.alert-success", text: "Help request cleared!")
          within(".students-help-list") do
            expect(all("tr")[1].all("td")[0].text).to eq(@students[1].name)
            expect(page).to_not have_text(@students[0].name)
            expect(page).to_not have_text(@students[2].name)
          end
        end

      end

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
    # TODO: shouldn't student also be able to clear their own request?
      # (they could easily answer their own question before the teacher gets to them...)
    # older help requests on the top...

# when teacher clears help request (after talking to student)
  # student disappears from teacher dashboard alert
  # button to request help shows up again for student
