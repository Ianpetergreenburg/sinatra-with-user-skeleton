require 'spec_helper'

describe 'login controller' do

  describe 'GET "/login"' do
    it 'loads the login page' do
      get('/login')
      expect(last_response).to be_ok
    end

    it 'contains login form' do
      get('/login')
      expect(last_response.body).to have_tag('form', with: {:action => '/login', :method => 'post'})
    end
  end

  describe 'POST "/login"' do
    before :each do
      @user = User.create(username: 'phteven', email: 'email@me.com', password: 'password')
    end

    it 'logs in users who give correct information' do
      post '/login', params={user: {username: 'phteven', password: 'password'}}
      expect(session[:user_id]).to eq @user.id
    end

    it 'redirects users who successfully login to the home page' do
      post '/login', params={user: {username: 'phteven', email: 'email@me.com', password: 'password'}}
      follow_redirect!

      expect(last_request.url).to eq 'http://example.org/'
      expect(last_request.request_method).to eq 'GET'
    end

    it 'shows users who unsuccessfully login the login page again' do
      post '/login', params={user: {username: 'phteven', password: 'not the password'}}

      expect(last_response.body).to have_tag('form', with: {:action => '/login', :method => 'post'})
    end

    it 'contains login form' do
      get('/login')
      expect(last_response.body).to have_tag('form', with: {:action => '/login', :method => 'post'})
    end
  end


  describe 'GET "/logout"' do
    it 'loads the home page' do
      get '/logout'
      follow_redirect!

      expect(last_request.url).to eq 'http://example.org/'
      expect(last_request.request_method).to eq 'GET'
      expect(last_response).to be_ok
    end

    it 'logs a user out' do
      User.create(username: 'phteven', email: 'email@me.com', password: 'password')
      post '/login', params = {user: {username: 'phteven', email: 'email@me.com', password: 'password'}}
      expect(session[:user_id]).to_not be nil
      get '/logout'
      expect(session[:user_id]).to eq nil
    end
  end
end
