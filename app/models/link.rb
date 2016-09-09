class Link < ActiveRecord::Base
  belongs_to :user
  before_create :convert_original_url
  validates :original, presence: true,
                       format: { with: %r{\A^http|https:\/\/},
                             notice: 'Your URL should include http/https' }
  validates :slug, uniqueness: true



  def convert_original_url
    alphabet = ("a".."z").to_a + (0..9).to_a
    self.slug = (0...6).map{ alphabet.to_a[rand(alphabet.size)] }.join
  end

  def shortened_url
    ENV["BASE_URL"] + self.slug
  end

  def details
  end
end
