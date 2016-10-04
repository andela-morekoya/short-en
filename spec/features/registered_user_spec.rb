require "rails_helper"

RSpec.feature "Registered User Features", type: :feature do
  before :each do
    fill_signup_form
    visit dashboard_path
    shorten_link_with_vanity(Faker::Internet.url, Faker::Lorem.characters(6))
  end

  describe "User visits site", js: true do
    context "enters valid url with vanity string" do
      it "returns a service shortened URL with specified vanity" do
        visit dashboard_path
        shorten_link_with_vanity(Faker::Internet.url, "vanity")
        expect(page).to have_content "Your Shortened Link"
        expect(Link.last.slug).to eq("vanity")
      end
    end

    context "visit user page" do
      it "lists of all user's service shortened URLs" do
        visit dashboard_path
        expect(page).to have_content Link.last.shortened_url
      end

      it "gives links to each url detail page" do
        expect(page).to have_content "Detail"
      end
    end

    context "view a shortened URL details page" do
      it "gives details about each individual who has used the URL" do
        click_on("Detail")
        expect(page).to have_content "IP Address"
      end
    end
  end
end
