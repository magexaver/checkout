# checkout

This is a simple example that calculates the final price of the basket depending on the discount rules

Example:
  Creating a product is simple, it contains the following parameters: product code, name and starting price
   # { code: '003', name: 'Kids T-shirt', price: 19.95 }
  
 It is very interesting and simple to create discount rules.
 You can create rules for the total price of the basket, as well as for the number of certain items, or both.
 # { value: { 60  => 10 }, volume: { '001' => [2 => 8.5] } }
 value:  price and discount, if the amount of the basket exceeds the price, then the discount is triggered
 volume: product code, quantity and new price. If the quantity of a certain product changes in the basket, the new price is recognized according to the rules
