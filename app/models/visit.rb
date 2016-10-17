class Visit < ActiveRecord::Base
  belongs_to :user
  belongs_to :link

  scope :popular_links, lambda {
                          group(:link_id).count.
                            sort_by { |_link, count| count }.reverse
                        }
  scope :registered,        -> { select(:user_id).where.not(user_id: 0) }
  scope :influential_users, -> { group(:user_id) }

  def self.save_visit(link, user, ip)
    visit = Visit.new
    visit.link_id = link.id
    visit.user_id = (user.id if user) || 0
    visit.ip_address = ip
    visit.save
  end

  def self.delete(link)
    Visit.where(link_id: link.id).destroy_all
  end
end
