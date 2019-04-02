require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
  end

  describe 'roles' do
    it 'can be created as a default user' do
      user = User.create(
        email: "email",
        password: "password",
        name: "name",
        address: "address",
        city: "city",
        state: "state",
        zip: "zip"
      )
      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as a merchant' do
      user = User.create(
        email: "email",
        password: "password",
        name: "name",
        address: "address",
        city: "city",
        state: "state",
        zip: "zip",
        role: 1
      )
      expect(user.role).to eq('merchant')
      expect(user.merchant?).to be_truthy
    end

    it 'can be created as an admin' do
      user = User.create(
        email: "email",
        password: "password",
        name: "name",
        address: "address",
        city: "city",
        state: "state",
        zip: "zip",
        role: 2
      )
      expect(user.role).to eq('admin')
      expect(user.admin?).to be_truthy
    end
  end
end
