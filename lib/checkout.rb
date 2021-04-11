require_relative "./price_calculator.rb"

class Checkout
  def initialize(prices, rules)
    @price_calculator = PriceCalculator.new(prices, rules)
  end
  # NOTE: I've made a concious decision of not using an attr_reader. We can discuss later.

  def scan(item)
    basket << item.to_sym
  end

  def total
    basket.tally
          .map { |item, count| @price_calculator.calculate(item, count) }
          .sum
  end

  private

  def basket
    @basket ||= Array.new
  end
end
