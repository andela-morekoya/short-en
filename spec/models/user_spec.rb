require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with a username, email and password" do
    user = User.new(
      username: "random",
      email: "random@something.com",
      password: "something_else")
        
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

  it "does not accept duplicate emails" do
    User.create(
      username: "random",
      email: "random@something.com",
      password: "something_else")

    user2 = User.new(email: "random@something.com")

    user2.valid?

    expect(user2.errors[:email]).to include "has already been taken"
  end
end
