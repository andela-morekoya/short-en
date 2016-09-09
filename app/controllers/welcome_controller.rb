class WelcomeController < ApplicationController
  def index
    @link = Link.new
    @popular_links = Link.order(visits: :desc).first(5)
    @recent_links = Link.order(created_at: :desc).first(5)
  end
end
