class Checkout
  attr_reader :prices
  private :prices

  def initialize(prices)
    @prices = prices
  end

  def scan(item)
    basket << item.to_sym
  end

  def total
    basket.tally
          .map { |item, count|
            case item
            when :apple, :pear
              if (count % 2 == 0)
                prices.fetch(item) * (count / 2)
              else
                prices.fetch(item) * count
              end
            when :pineapple
              (prices.fetch(item) / 2) + (prices.fetch(item)) * (count - 1)
            when :banana
              (prices.fetch(item) / 2) * count
            else
              prices.fetch(item) * count
            end
          }.sum
  end

  private

  def basket
    @basket ||= Array.new
  end
end
