require "rails_helper"

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "shows the create account page" do
      get :new
      expect(assigns(:user)).to be_a_new User
      expect(response).to render_template("new")
    end
  end

  describe "#create" do
    it "creates valid user" do
      expect do
        post :create, user: FactoryGirl.attributes_for(:user)
      end.to change(User, :count).by 1
      expect(session[:user_id]).to_not be_nil
      expect(flash[:notice]).to be_present
    end
  end
end
