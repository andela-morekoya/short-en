require 'rails_helper'

RSpec.describe LinksController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Link. As you add validations to Link, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { 
    {:original => "http://something.com", :user_id => 2}
  }

  let(:invalid_attributes) {
    {:original => "something.com", :user_id => 2}
    {:original => "http://something.com", :user_id => nil}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # LinksController. Be sure to keep this updated too.
  # let(:valid_session) { {} }

  describe "GET #show" do
    include RSpec::Rails::RequestExampleGroup
    it "redirects slug to original url" do
      link = Link.create! valid_attributes
      get link.shortened_url
      expect(response).to redirect_to(link.original)
    end
  end

  describe "GET #new" do
    it "assigns a new link as @link" do
      get :new, params: {}
      expect(assigns(:link)).to be_a_new(Link)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Link" do
        expect {
          post :create, params: {link: valid_attributes}
        }.to change(Link, :count).by(1)
      end

      it "assigns a newly created link as @link" do
        post :create, params: {link: valid_attributes}
        expect(assigns(:link)).to be_a(Link)
        expect(assigns(:link)).to be_persisted
      end

      it "redirects to the created link" do
        post :create, params: {link: valid_attributes}
        expect(response).to redirect_to(Link.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved link as @link" do
        post :create, params: {link: invalid_attributes}
        expect(assigns(:link)).to be_a_new(Link)
      end

      it "re-renders the 'new' template" do
        post :create, params: {link: invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end
end
