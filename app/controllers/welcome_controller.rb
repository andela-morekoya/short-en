class WelcomeController < ApplicationController
  def index
    @link = Link.new
    @popular_links = Visit.popular_links.first(7)
    @recent_links = Link.recent.first(7)
    @influential_users = Visit.registered.influential_users
  end
end
