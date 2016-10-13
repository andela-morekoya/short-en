def shorten_link(url, vanity = "")
  unless vanity.empty?
    find(".dropdown-toggle").click
    find("#link_slug").set vanity
  end
  find("#link_original").set url
  find(".btn-shorten").click

end

def login(email, password)
  visit root_path
  click_on "Login"
  fill_in "session[email]", with: email
  fill_in "session[password]", with: password
  click_button "Log in"
  shorten_link(Faker::Internet.url)
end
