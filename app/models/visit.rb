class Visit < ActiveRecord::Base
  belongs_to :user
  belongs_to :link

  scope :popular_links, -> { group(:link_id) }
  scope :influential_users, -> { where.not(user_id: 0).group(:user_id) }

  def self.save_visit(link, user, ip)
    visit = Visit.new
    visit.link_id = link.id
    visit.user_id = user ? user.id : 0
    visit.ip_address = ip
    visit.save
  end
end
