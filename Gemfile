  source "https://rubygems.org"

ruby "2.3.1"
gem "rails", "~> 4.2.6"
gem "bootstrap-sass", "~> 3.3.6"
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem "jquery-rails"
gem "turbolinks"
gem 'jbuilder', '~> 2.0'
gem "bcrypt", "~> 3.1.7"
gem "puma", "~> 3.6"
gem "json"
gem "coveralls", require: false
gem "nokogiri"

group :development, :test do
  gem "sqlite3"
  gem "byebug"
  gem "capybara", "~> 2.8", ">= 2.8.1"
  gem "capybara-webkit"
  gem "rspec-rails", "~> 3.5", ">= 3.5.2"
  gem "meta_request", "~> 0.4.0"
end

group :development do
  gem 'web-console', '~> 2.0'
  gem "spring"
end

group :test do
  gem "shoulda-matchers"
  gem "faker"
  gem "codeclimate-test-reporter", require: nil
  gem 'database_cleaner'
end

group :production do
  gem "pg", "~> 0.18.4"
  gem "rails_12factor", "~> 0.0.3"
end
