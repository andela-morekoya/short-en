require "rails_helper"

RSpec.describe Visit, type: :model do
  describe "Associations" do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :link }
  end
end
