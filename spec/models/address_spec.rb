require 'rails_helper'

RSpec.describe Address, type: :model do
  it {should validate_presence_of :nickname}
  it {should validate_presence_of :address}
  it {should validate_presence_of :city}
  it {should validate_presence_of :state}
  it {should validate_presence_of :zip}

  describe 'relationships' do
    it {should belong_to :user}
  end
end
