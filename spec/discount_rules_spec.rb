require "spec_helper.rb"
require "./lib/discount_rules.rb"

RSpec.describe DiscountRules do
  describe "two_for_one" do
    it "applies to an even count of items" do
      expect(DiscountRules.two_for_one(10, 2)).to eq(10)
      expect(DiscountRules.two_for_one(10, 4)).to eq(20)
    end

    it "doesn't apply to odd count of items" do
      expect(DiscountRules.two_for_one(10, 3)).to eq(30)
    end
  end

  describe "half_price" do
    it "slices the price in half before multiplying by count" do
      expect(DiscountRules.half_price(10, 1)).to eq(5)
      expect(DiscountRules.half_price(10, 3)).to eq(15)
    end
  end

  describe "half_on_first" do
    it "applies half price on the first item, normal price on the following" do
      expect(DiscountRules.half_on_first(10, 1)).to eq(5)
      expect(DiscountRules.half_on_first(10, 3)).to eq(25)
    end
  end

  describe "buy_3_get_1" do
    it "makes each third item to be for free" do
      expect(DiscountRules.buy_3_get_1(10, 1)).to eq(10)
      expect(DiscountRules.buy_3_get_1(10, 2)).to eq(20)
      expect(DiscountRules.buy_3_get_1(10, 3)).to eq(20)
      expect(DiscountRules.buy_3_get_1(10, 4)).to eq(30)
    end
  end

  describe "none" do
    it "just applies price per item" do
      expect(DiscountRules.none(10, 2)).to eq(20)
      expect(DiscountRules.none(10, 5)).to eq(50)
    end
  end

  describe "apply" do
    it "applies a known rule to the price and count that are given" do
      expect(DiscountRules.apply(:two_for_one, 10, 2)).to eq(10)
      expect(DiscountRules.apply(:half_price, 10, 3)).to eq(15)
      expect(DiscountRules.apply(:half_on_first, 10, 4)).to eq(35)
      expect(DiscountRules.apply(:buy_3_get_1, 10, 4)).to eq(30)
    end

    it "applies the 'none' rule when given a nil rule" do
      expect(DiscountRules.apply(nil, 10, 2)).to eq(20)
    end

    it "applies the 'none' rule when given an unknown rule" do
      expect(DiscountRules.apply(:bonkers, 10, 2)).to eq(20)
    end
  end
end
