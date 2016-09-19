class Visit < ActiveRecord::Base
  belongs_to :links
  # attr_accessor :link_id, :user_id, :ip_address
end
