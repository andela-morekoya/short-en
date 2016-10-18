require "rails_helper"

RSpec.describe LinksHelper, type: :helper do
  describe "#visitor_name" do
    context "when a registered user visits the link" do
      it "displays the user's username" do
        user = FactoryGirl.create(:user)
        visit = Visit.create(user_id: user.id, link_id: 1)

        expect(visitor_name(visit)).to eq user.username
      end
    end

    context "when anonymous user visits the link" do
      it "dispays the username as 'Anonymous'" do
        visit = Visit.create(user_id: 0, link_id: 1)

        expect(visitor_name(visit)).to eq "Anonymous"
      end
    end
  end
end
