class Link < ActiveRecord::Base
  belongs_to :user
  has_many :visits
  before_create :convert_original_url, :set_title
  before_update :set_title
  validates :user_id, :original, presence: true
  validates :original, format: { 
                                  with: URI.regexp,
                                  notice: 'Please enter a valid URL' 
                                }
  validates :slug, uniqueness: true

  def shortened_url
    ENV["BASE_URL"] + self.slug
  end

  def self.popular
    Link.order(visits: :desc).first(7)
  end

  def self.recent
    Link.order(created_at: :desc).first(7)
  end

  protected

  def convert_original_url
    alphabet = ("a".."z").to_a + (0..9).to_a
    self.slug ||= (0...6).map{ alphabet.sample }.join
  end

  def set_title
    self.title = self.get_title
  end

  def get_title
    begin
      page = Net::HTTP.get(URI(self.original))
      Nokogiri::HTML::Document.parse(page).title.squish
    rescue SocketError
      self.original
    end
  end
end
