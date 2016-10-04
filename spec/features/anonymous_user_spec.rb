require "rails_helper"

RSpec.feature "Anonymous User Features", type: :feature do
  describe "user visits site" do
    context "enters valid url" do
      it "returns a service shortened URL" do
        visit root_path
        shorten_link(Faker::Internet.url)
        expect(page).to have_content "Link was successfully created"
      end
    end

    context "enters an invalid Url" do
      it "gives an invalid url error" do
        visit root_path
        shorten_link("invalid_url")

        expect(page).to have_content "Please enter a valid URL (with http)"
      end
    end

    it "lists URLs sorted by popularity" do
      visit root_path
      expect(page).to have_content "Popular Links"
      # expect(page).to have_content Visit.popular_links
    end

    it "lists URLs sorted by how recently they were added" do
      visit root_path
      expect(page).to have_content "Recent Links"
    end  

    it "lists influential users" do
      visit root_path
      expect(page).to have_content "Influential Users"
    end  
  end
end
