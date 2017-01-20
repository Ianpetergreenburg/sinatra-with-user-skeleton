require_relative '../spec_helper'

describe 'index controller' do
  describe 'GET "/"' do
    it 'loads the homepage' do
      get('/')
      expect(last_response).to be_ok
    end

    it 'contains appropriate header' do
      get('/')
      expect(last_response.body).to have_tag("div", with: {id: 'home'})
    end
  end
end
