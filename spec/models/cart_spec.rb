require 'rails_helper'

RSpec.describe Cart do
  describe "Cart with existing contents" do
    before :each do
      @cart = Cart.new({"1" => 3, "4" => 2})
    end

    describe "#contents" do
      it "returns the contents" do
        expect(@cart.contents).to eq({"1" => 3, "4" => 2})
      end
    end

    describe "#count_of" do
      it "counts a particular item" do
        expect(@cart.count_of(1)).to eq(3)
      end
    end

    describe "#add_item" do
      it "increments an existing item" do
        @cart.add_item(1)
        expect(@cart.count_of(1)).to eq(4)
      end

      it "can increment an item not in the cart yet" do
        @cart.add_item(2)
        expect(@cart.count_of(2)).to eq(1)
      end
    end
  end

  describe "Cart with empty contents" do
    before :each do
      @cart = Cart.new(nil)
    end

    describe "#contents" do
      it "returns empty contents" do
        expect(@cart.contents).to eq({})
      end
    end

    describe "#count_of" do
      it "counts non existent items as zero" do
        expect(@cart.count_of(1)).to eq(0)
      end
    end

    describe "#add_item" do
      it "increments the item's count" do
        @cart.add_item(2)
        expect(@cart.count_of(2)).to eq(1)
      end
    end
  end
end
