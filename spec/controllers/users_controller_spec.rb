require "rails_helper"

RSpec.describe UsersController, type: :controller do
  include Messages

  describe "#new" do
    it "shows the create account page" do
      get :new
      expect(assigns(:user)).to be_a_new User
      expect(response).to render_template("new")
    end
  end

  describe "#create" do
    context "with valid params" do
      it "creates valid user" do
        post :create, user: FactoryGirl.attributes_for(:user)

        expect(User.count).to eq 1
        expect(session[:user_id]).to_not be_nil
        expect(flash[:notice]).to eq success("Account", "created")
      end
    end

    context "with invalid params" do
      it "reloads the signup page with errors listed" do
        post :create, user: { email: "invalid" }

        expect(response).to render_template "new"
      end
    end
  end
end
