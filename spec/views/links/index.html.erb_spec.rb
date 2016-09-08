require 'rails_helper'

RSpec.describe "links/index", type: :view do
  before(:each) do
    assign(:links, [
      Link.create!(
        :original => "Original",
        :slug => "Slug",
        :visits => 2,
        :active => false
      ),
      Link.create!(
        :original => "Original",
        :slug => "Slug",
        :visits => 2,
        :active => false
      )
    ])
  end

  it "renders a list of links" do
    render
    assert_select "tr>td", :text => "Original".to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
