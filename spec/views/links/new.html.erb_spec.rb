require 'rails_helper'

RSpec.describe "links/new", type: :view do
  before(:each) do
    assign(:link, Link.new(
      :original => "MyString",
      :slug => "MyString",
      :visits => 1,
      :active => false
    ))
  end

  it "renders new link form" do
    render

    assert_select "form[action=?][method=?]", links_path, "post" do

      assert_select "input#link_original[name=?]", "link[original]"

      assert_select "input#link_slug[name=?]", "link[slug]"

      assert_select "input#link_visits[name=?]", "link[visits]"

      assert_select "input#link_active[name=?]", "link[active]"
    end
  end
end
