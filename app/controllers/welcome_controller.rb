class WelcomeController < ApplicationController
  def index
    @link = Link.new
    @popular_links = Visit.popular_links.count.sort_by { |link, count| count }\
                     .reverse.first(7)
    @recent_links = Link.recent.first(7)
    @influential_users = Visit.registered.influential_users.first(7)
  end
end
