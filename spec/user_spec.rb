require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it 'saves a user with a password and password confirmation' do
      user = User.new(email: "test@example.com", password: "password", password_confirmation: "password")
      user.save
      expect(user).to be_present
    end

    it 'validates password and password_confirmation match' do
      user = User.new(email: "test@example.com", password: "password", password_confirmation: "wrong_password")
      user.save
      expect(user.errors.full_messages_for(:password_confirmation)). to include("Password confirmation doesn't match Password")
    end

    it 'validates the presence of password' do
      user = User.new(email: "test@example.com", password: nil, password_confirmation: "password")
      user.save
      expect(user.errors.full_messages_for(:password)). to include("Password can't be blank")
    end

    it 'validates the presence of password confirmation' do
      user = User.new(email: "test@example.com", password: "password", password_confirmation: nil)
      user.save
      expect(user.errors.full_messages_for(:password_confirmation)). to include("Password confirmation can't be blank")
    end


  end
end