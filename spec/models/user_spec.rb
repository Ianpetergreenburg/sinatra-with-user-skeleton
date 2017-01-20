require 'spec_helper'

describe User do


  describe 'validations' do

    subject { User.new(username: 'user', email: 'email@me.com', password: 'password') }

    it 'it should require a unique user name' do
      should validate_presence_of :username
      should validate_uniqueness_of :username
    end

    it 'it should require a unique email' do
      should validate_presence_of :email
      should validate_uniqueness_of :email
    end

    it 'it should require a password' do
      should have_secure_password
    end

  end

end
