require "rails_helper"

RSpec.feature "Registered user logs in", type: :feature, js: true do
  let!(:user) { FactoryGirl.create(:user, password: "password") }

  before do
    login(user.email, "password")
    visit dashboard_path
  end

  scenario "they can supply the vanity string to shorten url" do
    vanity = "vanity"

    shorten_link(Faker::Internet.url, vanity)

    expect(page).to have_content "Link was successfully created"
    expect(Link.last.slug).to eq(vanity)
  end

  scenario "they see all their shortened links" do
    expect(page).to have_content Link.last.shortened_url
  end

  scenario "they can get details of each of their links" do
    click_link "Details"

    expect(page).to have_content "IP Address"
  end

  scenario "they can deactivate a link" do
    click_link "Edit"
    uncheck "link_active"
    click_button "Update Link"
    click_link "Edit"

    expect(find("#link_active")).to_not be_checked
  end
end
