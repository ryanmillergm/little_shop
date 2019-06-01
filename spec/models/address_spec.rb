require 'rails_helper'

RSpec.describe Address, type: :model do
  it {should validate_presence_of :nickname}
  it {should validate_presence_of :address}

  describe 'relationships' do
    it {should belong_to :user}
    it {should belong_to :order}
  end
end
