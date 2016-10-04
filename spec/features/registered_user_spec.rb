# require "rails_helper"

# RSpec.feature "Registered User Features", type: :feature do
#   before :each do
#     fill_signup_form

#     # log_in(User.last.email, "p@ssw0rd")
#     visit dashboard_path
#     save_and_open_page
#     shorten_link_with_vanity(Faker::Internet.url, "vanity")
#   end

#   describe "user visits site", js: true do
#     context "enters valid url with vanity string"  do
#       it "returns a service shortened URL with specified vanity" do
#          expect(page).to have_content "Link was successfully created"
#         expect(Link.last.slug).to equal "vanity"
#       end
#     end

#     context "visit user page" do
#       it "lists of all user's service shortened URLs" do
#         expect(page).to have_content Link.last.shortened_url
#       end

#       it "gives links to each url detail page" do
#         expect(page).to have_content "Detail"
#       end
#     end

#     context "view a shortened URL details page" do
#       it "gives details about each individual who has used the URL" do
#         find("[data-toggle='collapse']").click.first

#         expect(page).to have_content "IP Address"
#       end
#     end
#   end
# end
