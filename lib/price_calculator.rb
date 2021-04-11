require_relative "./discount_rules.rb"

class PriceCalculator
  def initialize(prices, rules)
    @prices = prices
    @rules = rules
  end
  # NOTE: I've made a concious decision of not using an attr_reader. We can discuss later.

  def calculate(item, count)
    rule = @rules[item]
    price = @prices[item]

    DiscountRules.apply(rule, price, count)
  end
end
