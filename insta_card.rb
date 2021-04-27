# amsterdam_store = {
#   "Magic Shrooms" => 20.5,
#   "Maryjane" => 5,
#   "Lucy in the sky with diamonds" => 45,
#   "White christmas" => 30
# }

# access amsterdam_store["Magic Schrooms"]
# would return 20.5 (integer)

# 1) Refactor the store hash into something like this:
#
amsterdam_store = {
  "Magic Shrooms" => { "price" => 20.5, "amount" => 100 },
  "Maryjane" => { "price" => 5, "amount" => 100 },
  "Lucy in the sky with diamonds" => { "price" => 45, "amount" => 100 },
  "White christmas" => { "price" => 30, "amount" => 100 }
}

# access amsterdam_store["Magic Schrooms"]
# would return { "price" => 20.5, "amount" => 100 } (hash)
# amsterdam_store["Magic Schrooms"]["amount"]

shopping_cart = {}

# shopping_cart = {
#   "Magic Schrooms" => 30
# }

puts "--------------------"
puts "Welcome to Instacart"
puts "--------------------"
puts "In our store today:"

# 2) in this loop, price is not price anymore.. it's actually a hash
# with price and quantity available.
# We need to fix this loop!
amsterdam_store.each do |drug, attrb|
  puts "#{drug}: #{attrb["price"]}€ - qtd: #{attrb["amount"]}"
end

puts "--------------------"

user_answer = "whatever"

while user_answer != 'quit'
  puts "Which item? (or 'quit' to checkout)"
  user_answer = gets.chomp

  if amsterdam_store.key?(user_answer)
    puts "How many?"
    qty = gets.chomp.to_i

    # 3) Check if quantity is available (yes, new if/else)
    # if it is, follow the code that you were using before
    # if not, puts a msg saying "We only have X available..."

    if amsterdam_store[user_answer]["amount"] >= qty

      if shopping_cart.key?(user_answer)
        shopping_cart[user_answer] += qty
      else
        shopping_cart[user_answer] = qty
      end

      amsterdam_store[user_answer]["amount"] -= qty
    else

      puts "Sorry, we only have #{amsterdam_store[user_answer]["amount"]} amount"

    end

  elsif user_answer != 'quit'
    puts "Sorry, we don't have #{user_answer} today.."
  end
end

total_bill = 0

puts "-------BILL---------"

# 4) Refactor how we get the price
shopping_cart.each do |drug, quantity|
  # price
  price = amsterdam_store[drug]["price"]
  total = price * quantity

  puts "#{drug}: #{quantity} X #{price} = #{total}€"

  total_bill += total
end

puts "TOTAL: #{total_bill}€"
puts "--------------------"


p amsterdam_store
