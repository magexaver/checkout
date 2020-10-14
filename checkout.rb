class Checkout
  attr_reader :promotional_rules, :product_list, :h

  def initialize(promotional_rules={value: {}, volume: {}})
    @promotional_rules  = promotional_rules
    @product_list       = Array.new
    @h                  = Hash.new(0)
  end

  def add(item)
    product_list << item
  end

  def total
    value_discount(volume_discount.inject(0) { |sum, item| sum + item[:price] * item[:count] }).round(2)
  end

  def basket
    product_list.map { |item| item[:code] }.join(', ')
  end

  private

  def product_list_count
    product_list.each { |item| h[item] += 1 }
    h.keys.map { |k| k[:count] = h[k]; k }
  end

  def volume_discount
    product_list_count.each do |item|
      item[:price] = new_price_item(item)
    end
  end

  def new_price_item(item)
    return item[:price] unless promotional_rules[:volume].keys.include?(item[:code])
    promotional_rules[:volume][item[:code]].nil? ? item[:price] : promotional_rules[:volume][item[:code]][0].reject { |k, _| k > item[:count]  }.max&.last || item[:price]
  end

  def value_discount(amount)
    return amount if promotional_rules[:value].reject { |k, _| k > amount }.empty?
    amount - amount * promotional_rules[:value].reject { |k, _| k > amount }.max&.last / 100.0
  end
end

# Product code  | Name                   | Price
# -------------------------------------------------
# 001           | Lavender heart         | £9.25
# 002           | Personalised cufflinks | £45.00
# 003           | Kids T-shirt           | £19.95

item_1 = { code: '001', name: 'Lavender heart',         price: 9.25 }
item_2 = { code: '002', name: 'Personalised cufflinks', price: 45.00 }
item_3 = { code: '003', name: 'Kids T-shirt',           price: 19.95 }

promotional_rules = {
  value: {
    60  => 10,
    100 => 15,
    200 => 20
    },
  volume: {
    '001' => [
            2 => 8.5
           ]
  }
}

# Basket:          001,002,003
# Total price expected: £66.78
co_1 = Checkout.new(promotional_rules)
co_1.add(item_1)
co_1.add(item_2)
co_1.add(item_3)
price_1 = co_1.total
puts "Basket: #{co_1.basket}"
puts "Total price expected: £#{price_1}"
puts "-------------------------------------"

# Basket:          001,003,001
# Total price expected: £36.95
co_2 = Checkout.new(promotional_rules)
co_2.add(item_1)
co_2.add(item_3)
co_2.add(item_1)
price_2 = co_2.total
puts "Basket: #{co_2.basket}"
puts "Total price expected: £#{price_2}"
puts "-------------------------------------"

# Basket:      001,002,001,003
# Total price expected: £73.76
co_3 = Checkout.new(promotional_rules)
co_3.add(item_1)
co_3.add(item_2)
co_3.add(item_1)
co_3.add(item_3)
price_3 = co_3.total
puts "Basket: #{co_3.basket}"
puts "Total price expected: £#{price_3}"
