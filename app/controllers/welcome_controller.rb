class WelcomeController < ApplicationController
  def index
    @link = Link.new
    @popular_links = Link.popular
    @recent_links = Link.recent
    @influential_users = get_influential_users
  end

  def get_influential_users
    link_visits = Link.select(:user_id, :visits).where('user_id > 0')
    influential_links = link_visits.group(:user_id).sum(:visits).to_a.reverse
    influential_users = []
    influential_links.each do |item|
      influential_users.push(User.find(item[0]).username)
    end
    influential_users
  end
end
