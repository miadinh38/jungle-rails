require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it 'saves a user with a password and password confirmation' do
      user = User.new(name: "Example", email: "test@example.com", password: "password", password_confirmation: "password")
      user.save
      expect(user).to be_present
    end

    it 'validates password and password_confirmation match' do
      user = User.new(name: "Example", email: "test@example.com", password: "password", password_confirmation: "wrong_password")
      user.save
      expect(user.errors.full_messages_for(:password_confirmation)). to include("Password confirmation doesn't match Password")
    end

    it 'validates the presence of password' do
      user = User.new(name: "Example", email: "test@example.com", password: nil, password_confirmation: "password")
      user.save
      expect(user.errors.full_messages_for(:password)). to include("Password can't be blank")
    end

    it 'validates the presence of password confirmation' do
      user = User.new(name: "Example", email: "test@example.com", password: "password", password_confirmation: nil)
      user.save
      expect(user.errors.full_messages_for(:password_confirmation)). to include("Password confirmation can't be blank")
    end
    
    it 'validates presence of email' do
      user = User.new(name: "Example", email: nil, password: "password", password_confirmation: "password")
      user.save
      expect(user.errors.full_messages_for(:email)).to include("Email can't be blank")
    end

    it 'validates uniquiness of email' do
      user1 = User.new(name: "Example", email: "test@example.com", password: "password", password_confirmation: "password")  
      user2 = User.new(name: "Example", email: "test@example.COM", password: "password2", password_confirmation: "password2") 
      user1.save 
      user2.save
      expect(user2.errors.full_messages_for(:email)). to include("Email has already been taken")
    end

    it 'validates presence of name' do
      user = User.new(name: nil, email: "test@example.com", password: "password", password_confirmation: "password")
      user.save
      expect(user.errors.full_messages_for(:name)).to include("Name can't be blank")
    end

    it 'validates length of passwword' do
      user = User.new(name: "Example", email: "test@example.com", password: "123", password_confirmation: "123")
      user.save
      expect(user.errors.full_messages_for(:password)).to include("Password is too short (minimum is 5 characters)")
    end
  end

  describe '.authenticate_with_credentials' do
    let!(:user) { User.create(name: "Example User", email: "user@example.com", password: "password", password_confirmation: "password") }
    
    context 'with leading/trailing whitespace in email' do
      it 'returns the user instance' do
        authenticated_user = User.authenticate_with_credentials('  user@example.com  ', 'password')
        expect(authenticated_user).to eq(user)
      end
    end

    context 'with different case in email' do
      it 'returns the user instance' do
        authenticated_user = User.authenticate_with_credentials('USER@example.com', 'password')
        expect(authenticated_user).to eq(user)
      end
    end

    context 'with valid credentials' do
      it 'returns the user instance' do
        authenticated_user = User.authenticate_with_credentials('user@example.com', 'password')
        expect(authenticated_user).to eq(user)
      end
    end

    context 'with invalid email' do
      it 'return nil' do
        authenticated_user = User.authenticate_with_credentials('user1@example.com', 'password')
        expect(authenticated_user).to be_nil
      end
    end  

    context 'with invalid password' do
      it 'return nil' do
        authenticated_user = User.authenticate_with_credentials('user@example.com', 'wrong_password')
        expect(authenticated_user).to be_nil
      end
    end  
  end
end