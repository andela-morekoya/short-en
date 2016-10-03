class Link < ActiveRecord::Base
  belongs_to :user
  has_many :visits
  validates :user_id, :original, presence: true
  validates :original, format: { 
                                  with: URI::regexp,
                                  notice: 'Please enter a valid URL' 
                                }
  validates :slug, uniqueness: true
  before_save :set_slug, :set_title

  def shortened_url
    ENV["BASE_URL"] + self.slug
  end

  def visits
    Visit.where(link_id: self.id).count
  end

  def self.popular
    Link.order(visits: :desc).first(7)
  end

  def self.recent
    Link.order(created_at: :desc).first(7)
  end

  protected

  def set_slug
    self.slug = self.slug.parameterize if self.slug

    if self.slug.nil? || self.slug.empty?
      self.slug = convert_original_url
    end
  end

  def convert_original_url
    alphabet = ("a".."z").to_a + (0..9).to_a
    (0...6).map{ alphabet.sample }.join
  end

  def set_title
    self.title = self.get_title
  end

  def get_title
    begin
      page = Net::HTTP.get(URI(self.original))
      Nokogiri::HTML::Document.parse(page).title.squish
    rescue SocketError, OpenTimeout => e
      e.message
    end
  end
end
