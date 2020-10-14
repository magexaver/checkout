# checkout

This is a simple example that calculates the final price of the basket depending on the discount rules

Example:
  Creating a product is simple, it contains the following parameters: product code, name and starting price
   # { code: '003', name: 'Kids T-shirt', price: 19.95 }
  
 It is very interesting and simple to create discount rules.
 You can create rules for the total price of the basket, as well as for the number of certain items, or both.
 {
  value: { 60  => 10 },
  volume: { '001' => [2 => 8.5] }
 }
