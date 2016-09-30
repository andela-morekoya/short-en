require 'rails_helper'

RSpec.describe Link, type: :model do
  it "is valid with a full original url and a user ID" do
    link = Link.new(original: Faker::Internet.url, user_id: "1")

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
    link = Link.create(original: Faker::Internet.url, user_id: "1")

    expect(link.slug).to_not be_empty
  end

  it "returns the slug as a url" do
    link = Link.create(original: Faker::Internet.url, user_id: "1")
    expect(link.shortened_url).to include("http")
  end
end
