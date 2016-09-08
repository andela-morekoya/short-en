require 'rails_helper'

RSpec.describe "links/edit", type: :view do
  before(:each) do
    @link = assign(:link, Link.create!(
      :original => "MyString",
      :slug => "MyString",
      :visits => 1,
      :active => false
    ))
  end

  it "renders the edit link form" do
    render

    assert_select "form[action=?][method=?]", link_path(@link), "post" do

      assert_select "input#link_original[name=?]", "link[original]"

      assert_select "input#link_slug[name=?]", "link[slug]"

      assert_select "input#link_visits[name=?]", "link[visits]"

      assert_select "input#link_active[name=?]", "link[active]"
    end
  end
end
