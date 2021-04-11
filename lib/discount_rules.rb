module DiscountRules
  def self.two_for_one(price, count)
    price * (count / (count % 2 == 0 ? 2 : 1))
  end

  def self.half_price(price, count)
    price / 2 * count
  end

  def self.half_on_first(price, count)
    price / 2 + price * (count - 1)
  end

  def self.buy_3_get_1(price, count)
    price * (count / 3 * 2 + count % 3)
  end

  def self.none(price, count)
    price * count
  end
end
