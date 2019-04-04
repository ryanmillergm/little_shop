require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :price }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of :description }
    it { should validate_presence_of :inventory }
    it { should validate_numericality_of(:inventory).only_integer }
    it { should validate_numericality_of(:inventory).is_greater_than_or_equal_to(0) }
  end

  describe 'relationships' do
    it { should belong_to :user }
  end

  describe 'instance methods' do
    describe "#average_fulfillment_time" do
      it "calculates the average difference between order_item created and completion" do
        @merchant = create(:merchant)
        @item = create(:item, user: @merchant)
        @order_item_1 = create(:fulfilled_order_item, item: @item, created_at: 4.days.ago, updated_at: 12.hours.ago)
        @order_item_2 = create(:fulfilled_order_item, item: @item, created_at: 2.days.ago, updated_at: 1.day.ago)
        @order_item_3 = create(:fulfilled_order_item, item: @item, created_at: 2.days.ago, updated_at: 1.day.ago)
        @order_item_4 = create(:order_item, item: @item, created_at: 2.days.ago, updated_at: 1.day.ago)

        expect(@item.average_fulfillment_time.round(2)).to eq(1.83)
      end
    end
  end
end
