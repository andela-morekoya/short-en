require "rails_helper"

RSpec.describe Visit, type: :model do
  describe "Associations" do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :link }
  end

  describe "#delete" do
    it "removes all records of visits to specified link" do
      Link.create(FactoryGirl.attributes_for(:link) )
      Visit.create(user_id: 1, link: Link.last)
      Visit.delete(Link.last)

      expect(Visit.count).to eq 0
    end
  end
end
