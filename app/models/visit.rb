class Visit < ActiveRecord::Base
  belongs_to :user
  belongs_to :link

  scope :popular_links,     -> { get_popular }
  scope :registered,        -> { select(:user_id).where.not(user_id: 0) }
  scope :influential_users, -> { get_influential_users }

  def self.save_visit(link, user, ip)
    visit = new
    visit.link_id = link.id
    visit.user_id = (user.id if user) || 0
    visit.ip_address = ip
    visit.save
  end

  def self.delete(link)
    where(link_id: link.id).destroy_all
  end

  def self.get_popular
    group(:link_id).count.sort_by { |_link, count| count }.reverse
  end

  def self.get_influential_users
    group(:user_id).sort_by { |_user, count| count }.reverse
  end
end
