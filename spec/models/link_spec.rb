require "rails_helper"

RSpec.describe Link, type: :model do
  let(:link) { Link.create(original: Faker::Internet.url, user_id: "1") }

  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:visits) }
  end

  it "is valid with a full original url and a user ID" do
    expect(link).to be_valid
  end

  it "is invalid without a valid original url" do
    link = Link.new(original: nil)

    link.valid?

    expect(link.errors[:original]).to include("is invalid")
  end

  it "is invalid without a user ID" do
    link = Link.new(user_id: nil)

    link.valid?

    expect(link.errors[:user_id]).to include("can't be blank")
  end

  it "generates a short url when given a full url" do
    expect(link.slug).to_not be_empty
  end

  it "returns the slug as a url" do
    expect(link.shortened_url).to include("http")
  end
end
