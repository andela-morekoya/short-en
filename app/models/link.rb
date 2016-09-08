class Link < ActiveRecord::Base
  validates :original, :slug, :presence => true
  validates :slug, :uniqueness => true

  belongs_to :user
  after_create :convert_original_url


  def convert_original_url
    self.slug = self.id.to_s(36)
    self.save
  end

  def shortened_url
    ENV["BASE_URL"] + self.slug
  end

  def details
  end
end
