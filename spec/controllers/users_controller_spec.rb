require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it 'shows the create account page' do
      get :new
      expect(response).to render_template('new')
    end
  end
end
