require "rails_helper"

describe "request help" do

  describe "student perspective" do

    before(:each) do
      @student = FactoryGirl.create(:student)
    end

    describe "student show page" do

      describe "request help state is false" do

        it "should display request help button" do
          visit student_path(@student.id)
          expect(page).to have_selector("h1", text: "Welcome, #{@student.name}")
          expect(page).to have_selector("a.request-help", text: "Request Help From My Teacher")
        end

      end

      describe "request help state is true" do

        before(:each) do
          @student.help_request_state = true
          @student.save
        end

        it "should display request help button" do
          visit student_path(@student.id)
          expect(page).to_not have_selector("a.request-help", text: "Request Help From My Teacher")
          expect(page).to have_selector("p.teacher-notified", text: "Your teacher has been notified of your request for help.")
        end

      end

    end

    describe "student clicking request help button" do

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
        expect(page).to have_selector("h3", text: "The following students have requested help:")
        within(".students-help-list") do
          expect(all("tr")[1].all("td")[0].text).to eq(@student.name)
        end
      end

    end

    describe "student clearing own help request" do

      before(:each) do
        allow(Student).to receive(:find).and_return(@student)
        visit student_path(@student.id)
        click_link("Request Help From My Teacher")
        click_link("Clear Help Request")
      end

      it "should change student help request state in database" do
        expect(@student.help_request_state).to eq(false)
      end

      it "should show request help button again and display request cleared message on student page" do
        expect(page).to_not have_text("Your teacher has been notified of your request for help.")
        expect(page).to have_selector("a.request-help", text: "Request Help From My Teacher")
        expect(page).to have_selector("div.alert-success", text: "Help request cleared!")
      end

      it "should not show student help request on teacher page" do
        visit root_path
        expect(page).to_not have_selector(".students-help-list", text: @student.name)
      end

    end

  end

  describe "teacher perspective" do

    before(:each) do
      @students = FactoryGirl.create_list(:student_requesting_help, 4)
      @students[2].help_request_state = false
      @students[2].save
    end

    it "should display student help info on teacher dashboard" do
      visit root_path
      expect(page).to have_selector("h3", text: "The following students have requested help:")
      within(".students-help-list") do
        expect(all("tr")[1].all("td")[0].text).to eq(@students[0].name)
        expect(all("tr")[1].all("td")[1].text).to eq(Time.current.strftime("%-l:%M%P (%-m/%-d/%y)"))
        expect(all("tr")[1].all("td")[2]).to have_link("Clear Help Request")
        expect(all("tr")[2].all("td")[0].text).to eq(@students[1].name)
        expect(all("tr")[3].all("td")[0].text).to eq(@students[3].name)
        expect(page).to_not have_text(@students[2].name)
      end

    end

    describe "teacher clearing some student help requests" do

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
        expect(@students[1].help_request_state).to eq(true)
        expect(@students[2].help_request_state).to eq(false)
        expect(@students[3].help_request_state).to eq(false)
      end

      it "should change help request info on screen" do
        expect(page).to have_selector("div.alert-success", text: "Help request cleared!")
        within(".students-help-list") do
          expect(all("tr")[1].all("td")[0].text).to eq(@students[1].name)
          expect(page).to_not have_text(@students[0].name)
          expect(page).to_not have_text(@students[2].name)
          expect(page).to_not have_text(@students[3].name)
        end
      end

      describe "clearing all help requests" do

        it "should display no student help info" do
          visit root_path
          within(".students-help-list") do
            within(all("tr")[1]) do
              click_link("Clear Help Request")
            end
          end
          expect(page).to_not have_selector("h3", text: "The following students have requested help:")
        end

        it "should show request help button again on student page" do
          visit student_path(@students[3].id)
          expect(page).to have_selector("a.request-help", text: "Request Help From My Teacher")
        end

      end

    end

  end

end

# TODO: shouldn't student also be able to clear their own request?
  # (they could easily answer their own question before the teacher gets to them...)
# TODO: older help requests on the top...
