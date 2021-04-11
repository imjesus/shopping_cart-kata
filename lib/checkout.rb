require_relative "./discount_rules.rb"

class Checkout
  attr_reader :prices
  private :prices

  PRODUCT_PRICE_RULES = {
    apple:     DiscountRules.method(:two_for_one),
    pear:      DiscountRules.method(:two_for_one),
    banana:    DiscountRules.method(:half_price),
    pineapple: DiscountRules.method(:half_on_first),
    mango:     DiscountRules.method(:buy_3_get_1)
  }.tap do |it|
    it.default = DiscountRules.method(:none)
  end

  def initialize(prices)
    @prices = prices
  end

  def scan(item)
    basket << item.to_sym
  end

  def total
    basket.tally
          .map { |item, count| PRODUCT_PRICE_RULES[item].call(prices[item], count) }
          .sum
  end

  private

  def basket
    @basket ||= Array.new
  end
end
