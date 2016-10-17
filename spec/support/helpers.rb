def shorten_link(url, vanity = "")
  if vanity.present?
    find(".dropdown-toggle").click
    fill_in "link[slug]", with: vanity
  end

  fill_in "link[original]", with: url
  page.execute_script %($("#new_link").submit())
  wait_for_ajax
end

def login(email, password)
  visit root_path
  click_on "Login"
  fill_in "session[email]", with: email
  fill_in "session[password]", with: password
  click_button "Log in"
  shorten_link(Faker::Internet.url)
end
