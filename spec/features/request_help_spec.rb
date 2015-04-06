require "rails_helper"

describe "request help" do

  it "should display home page" do
    visit root_path
    expect(page).to have_content("eSpark Teacher Dashboard")
  end

end
