class Checkout
  attr_reader :prices
  private :prices

  DISCOUNT_RULES = {
    two_for_one: -> (price, count) { price * (count / (count % 2 == 0 ? 2 : 1)) },
    half_price: -> (price, count) { (price / 2) * count },
    half_on_first: -> (price, count) { price / 2 + price * (count - 1) },
    none: -> (price, count) { price * count }
  }.freeze

  PRODUCT_PRICE_RULES = {
    apple: DISCOUNT_RULES[:two_for_one],
    pear: DISCOUNT_RULES[:two_for_one],
    banana: DISCOUNT_RULES[:half_price],
    pineapple: DISCOUNT_RULES[:half_on_first]
  }.tap do |it|
    it.default = DISCOUNT_RULES[:none]
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
