require "spec_helper.rb"
require "./lib/price_calculator.rb"

RSpec.describe PriceCalculator do
  let(:product_prices) {
    {
      apple:      10,
      orange:     20,
      pear:       15,
      banana:     30,
      pineapple: 100,
      mango:     200
    }
  }

  let(:price_rules) {
    {
      apple:     :two_for_one,
      pear:      :two_for_one,
      banana:    :half_price,
      pineapple: :half_on_first,
      mango:     :buy_3_get_1
    }
  }

  subject(:calculator) { described_class.new(product_prices, price_rules) }

  it "calculates the price of each product/quantity group by applying the given rules" do
    expect(calculator.calculate(:apple, 4)).to eq(20)
    expect(calculator.calculate(:orange, 4)).to eq(80)
    expect(calculator.calculate(:pear, 4)).to eq(30)
    expect(calculator.calculate(:banana, 4)).to eq(60)
    expect(calculator.calculate(:pineapple, 4)).to eq(350)
    expect(calculator.calculate(:mango, 4)).to eq(600)
  end
end
