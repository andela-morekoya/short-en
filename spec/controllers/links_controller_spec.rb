require "rails_helper"

RSpec.describe LinksController, type: :controller do
  include Messages

  let(:user) { FactoryGirl.create(:user) }

  let(:link) { Link.create(FactoryGirl.attributes_for(:link)) }

  describe "before actions" do
    it { is_expected.to use_before_action(:authenticate) }
    it { is_expected.to use_before_action(:set_link) }
    it { is_expected.to use_before_action(:my_links) }
  end

  describe "#show" do
    context "when slug is valid and active" do
      it "redirects user to original url" do
        get :show, slug: link.slug

        expect(response).to redirect_to(link.original)
        expect(Visit.count).to eq 1
      end
    end

    context "when slug is inactive" do
      it "redirects user to original url" do
        link.update(slug: "inactive", active: false)
        get :show, slug: "inactive"

        expect(response).to render_template "layouts/error"
      end
    end

    context "when slug has been deleted" do
      it "redirects user to original url" do
        get :show, slug: "deleted"

        expect(response).to render_template "layouts/error"
      end
    end
  end

  describe "#dashboard" do
    context "when user is registered" do
      it "renders the dashboard" do
        session[:user_id] = user.id

        get :dashboard

        expect(response).to render_template "dashboard"
      end
    end

    context "when user is not registered" do
      it "redirects user to login page" do
        get :dashboard

        expect(response).to redirect_to login_path
      end
    end
  end

  describe "#new" do
    it "shows form to create a shortened link" do
      get :new

      expect(response).to render_template "new"
    end
  end

  describe "#edit" do
    context "when user is not registered" do
      it "redirects user to login page" do
        get :edit, id: link.id

        expect(response).to redirect_to login_path
      end
    end

    context "when user is registered" do
      it "shows form to create a shortened link" do
        session[:user_id] = user.id

        get :edit, id: link.id

        expect(response).to have_http_status(:success)
        expect(response).to render_template "edit"
      end
    end
  end

  describe "#create" do
    context "with invalid params" do
      it "should raise error" do
        post :create, link: { original: "something" }, format: "js"

        expect(flash[:alert]).to eq error("Link", "created")
      end
    end

    context "with valid params" do
      it "should be successful" do
        post :create, link: { original: "http://abc.com", user_id: 2 },
                      format: "js"

        expect(flash[:notice]).to eq success("Link", "created")
      end
    end
  end

  describe "#update" do
    context "when user is not registered" do
      it "redirects user to login page" do
        patch :update, id: link.id, link: { slug: "updated" }
        link.reload

        expect(response).to redirect_to login_path
      end
    end

    context "when user is registered and valid params used" do
      it "updates the link" do
        session[:user_id] = user.id

        patch :update, id: link.id, link: { slug: "updated" }, format: "js"
        link.reload

        expect(flash[:notice]).to eq success("Link", "updated")
        expect(link.slug).to eq "updated"
      end
    end

    context "when user is registered and invalid params used" do
      it "raises an error" do
        session[:user_id] = user.id

        patch :update, id: link.id, link: { original: "bad.com" }, format: "js"
        link.reload

        expect(flash[:alert]).to eq error("Link", "updated")
      end
    end
  end

  describe "#destroy" do
    context "when user is not registered" do
      it "redirects user to login page" do
        delete :destroy, id: link.id

        expect(response).to redirect_to login_path
      end
    end

    context "when user is registered" do
      it "deletes the link" do
        session[:user_id] = user.id

        delete :destroy, id: link.id

        expect(flash[:notice]).to eq success("Link", "deleted")
      end
    end
  end
end
