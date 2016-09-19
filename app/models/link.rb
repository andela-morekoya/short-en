class Link < ActiveRecord::Base
  belongs_to :user
  has_many :visit
  before_create :convert_original_url
  validates :user_id, :original, presence: true
  validates :original, format: { with: %r{\A^http|https:\/\/},
                             notice: 'Your URL should include http/https' }
  validates :slug, uniqueness: true

  def shortened_url
    ENV["BASE_URL"] + self.slug
  end

  def get_title
    # page = URI.parse(self.original).read
    # page.match(/<title>(.*)<\/title>/)[1]
    open('http://google.com/').read.match(/<title>(.*?)<\/title>/)[1]
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
    # self.slug = (0...6).map{ alphabet.to_a[rand(alphabet.size)] }.join
    self.slug = (0...6).map{ alphabet.sample }.join
  end
end
