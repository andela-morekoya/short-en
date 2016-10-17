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
    page.execute_script %($("link_active").checked = false)
    find_button("Update Link").click
    status = page.has_checked_field?("#link_active")
    expect(status).to be_falsey
  end
end
