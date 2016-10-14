require "rails_helper"

RSpec.feature "Anonymous user visits site", type: :feature, js: true do
  before do
    visit root_path
  end

  scenario "they can shorten a url" do
    shorten_link(Faker::Internet.url)

    expect(page).to have_content "your shortened link"
  end

  scenario "they see a list of popular urls" do
    expect(page).to have_content "Popular Links"
  end

  scenario "they see a list of recent urls" do
    expect(page).to have_content "Recent Links"
  end

  scenario "they see a list of influential users" do
    expect(page).to have_content "Influential Users"
  end

  scenario "they can create an account" do
    find(".sign-up", match: :first).click
    fill_in "Username", with: "Generic"
    fill_in "Email", with: Faker::Internet.email
    fill_in "Password", with: "p@ssw0rd"
    fill_in "Confirm Password", with: "p@ssw0rd"
    find(".btn-signup").click

    expect(page).to have_content("Welcome Generic")
  end
end
