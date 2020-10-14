require 'rspec/autorun'
require_relative './checkout.rb'

describe Checkout do
  let(:rules)    { { value: {}, volume: { '001' => [2 => 8.5] } } }
  let(:item)     { {code: '001', name: 'Lavender heart',  price: 9.25} }
  let(:checkout) { Checkout.new(rules) }

  it 'add items to cart' do
    2.times do
      checkout.add item
    end
    expect(checkout.product_list.size).to be(2)
    4.times do
      checkout.add item
    end
    expect(checkout.product_list.size).to be(6)
  end

  it 'calculation of the total price' do
    2.times do
      checkout.add item
    end
    expect(checkout.total).to be(17.0)
  end
end
