class Link < ActiveRecord::Base
  belongs_to :user
  has_many :visits

  before_validation :set_slug

  validates :user_id, :original, presence: true
  validates :original, format: {
    with: URI.regexp,
    notice: "Please enter a valid URL"
  }
  validates :slug, uniqueness: true

  before_save :set_title

  scope :recent, -> { order(created_at: :desc) }

  def shortened_url
    ENV["BASE_URL"] + slug
  end

  def visit_count
    visits.count
  end

  def self.get_my_links(user)
    where(user_id: user.id).order(created_at: :desc) if user
  end

  protected

  def set_slug
    self.slug = (slug.parameterize if slug.present?) || convert_original_url
  end

  def convert_original_url
    alphabet = ("a".."z").to_a + (0..9).to_a
    (0...6).map { alphabet.sample }.join
  end

  def set_title
    self.title = get_title
  end

  def get_title
    page = Net::HTTP.get(URI(original))
    Nokogiri::HTML::Document.parse(page).title.squish
  rescue SocketError, Net::OpenTimeout, NoMethodError, Errno::ECONNRESET
    original
  end
end
