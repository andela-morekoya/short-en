def log_in(email, password)
  visit login_path
  fill_in "Email", with: email
  fill_in "Password", with: password
  find(".btn-login").click
end

def shorten_link(url)
  fill_in "link_original", with: url
  find(".btn-shorten").click
end

def shorten_link_with_vanity(url, vanity)
  fill_in "link_original", with: url
  find(".dropdown-toggle").click
  fill_in "link_slug", with: vanity
  find_button("Shorten").trigger("click")
end

def fill_signup_form
  visit signup_path
  fill_in "Username", with: Faker::Name.first_name
  fill_in "Email", with: Faker::Internet.email
  fill_in "Password", with: "p@ssw0rd"
  fill_in "Confirm Password", with: "p@ssw0rd"
  find(".btn-signup").click
end
