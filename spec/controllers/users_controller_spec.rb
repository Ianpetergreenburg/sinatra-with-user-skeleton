require 'spec_helper'

describe 'users controller' do
  describe 'GET "/users/new"' do
    it 'loads the registration page' do
      get('/users/new')
      expect(last_response).to be_ok
    end

    it 'contains registration form' do
      get('/users/new')
      expect(last_response.body).to have_tag('form', with: {:action => '/users', :method => 'post'})
    end
  end

  describe 'POST "/users"' do

    it 'creates a new user with a name and password' do
      count = User.count
      post '/users', params={user: {username: 'phteven', email: 'email@me.com', password: 'password'}}
      expect(User.count).to eq (count + 1)
    end

    it 'redirects to the home page if successful' do
      post '/users', params={user: {username: 'phteven', email: 'email@me.com', password: 'password'}}
      follow_redirect!

      expect(last_request.url).to eq 'http://example.org/'
      expect(last_response).to be_ok
    end

    it 'displays form again if unsuccesful' do
       post '/users'

      expect(last_request.url).to eq 'http://example.org/users'
      expect(last_response.body).to have_tag('form', with: {:action => '/users', :method => 'post'})
      expect(last_response).to be_ok
    end
  end

  describe 'GET "/users/:id"' do
    before :each do
      @user = User.create(username: 'phteven', email: 'email@me.com', password: 'password')
    end

    it 'shows a user their own profile when logged in' do
      post '/login', params = {user: {username: 'phteven', email: 'email@me.com', password: 'password'}}
      get "/users/#{@user.id}"

      expect(last_response.body).to have_tag('div', with: {class: 'profile'})
    end

    it 'shows a user an error page if the user does not exist' do
      get "/users/#{@user.id + 1}"

      expect(last_response.body).to have_tag('h1', with: {class: 'error'})
    end
  end
end
