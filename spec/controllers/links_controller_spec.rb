require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  include RSpec::Rails::RequestExampleGroup

  let(:valid_attributes) do
    { original: Faker::Internet.url, user_id: 2 }
  end

  let(:invalid_attributes) do
    { original: 'something', user_id: nil }
  end

  describe 'before actions' do
    it { should use_before_action(:authenticate) }
    it { should use_before_action(:set_link) }
    it { should use_before_action(:my_links) }
  end

  describe 'GET #show' do
    it 'redirects slug to original url' do
      link = Link.create! valid_attributes
      get link.shortened_url
      expect(response).to redirect_to(link.original)
    end
  end

  describe 'POST #create' do
    context 'with invalid params' do
      it 'should raise error' do
        expect do
          post :create, params: { link: :invalid_attributes }
        end.to raise_error(URI::InvalidURIError)
      end
    end
  end
end
