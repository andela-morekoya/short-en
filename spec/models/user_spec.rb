require 'rails_helper'

RSpec.describe User, type: :model do
  before :all do
    user = User.new(
                      username: Faker::Name.first_name,
                      email: Faker::Internet.email,
                      password: Faker::Lorem.characters(8)
                    )
  end

  it "is valid with a username, email and password" do
    expect(user).to be_valid
  end

  it "is invalid without a username" do
    user = User.new(username: nil)
    
    user.valid?
    
    expect(user.errors[:username]).to include("can't be blank")
  end

  it "is invalid without an email" do
    user = User.new(email: nil)

    user.valid?

    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid without a password" do
    user = User.new(password: nil)

    user.valid?

    expect(user.errors[:password]).to include("can't be blank")
  end

  it "does not accept duplicate usernames" do
    user.save
    user2 = User.new(username: user.username)
    user2.valid?

    expect(user2.errors[:username]).to include "has already been taken"
  end

  it "does not accept duplicate emails" do
    user2 = User.new(email: user.email)
    user2.valid?

    expect(user2.errors[:email]).to include "has already been taken"
  end
end
