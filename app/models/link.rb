class Link < ActiveRecord::Base
  belongs_to :user
  has_many :visits
  validates :user_id, :original, presence: true
  validates :original, format: {
    with: URI.regexp,
    notice: 'Please enter a valid URL'
  }
  validates :slug, uniqueness: true
  before_save :set_slug, :set_title

  scope :recent, -> { order(created_at: :desc) }

  def shortened_url
    ENV['BASE_URL'] + slug
  end

  def visit_count
    visits.count
  end

  protected

  def set_slug
    self.slug = slug.parameterize if slug

    self.slug = convert_original_url if slug.nil? || slug.empty?
  end

  def convert_original_url
    alphabet = ('a'..'z').to_a + (0..9).to_a
    (0...6).map { alphabet.sample }.join
  end

  def set_title
    self.title = get_title
  end

  def get_title
    page = Net::HTTP.get(URI(original))
    Nokogiri::HTML::Document.parse(page).title.squish
  rescue SocketError, Net::OpenTimeout, NoMethodError
    original
  end
end
