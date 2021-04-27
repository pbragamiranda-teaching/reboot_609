# Pseudo-code:
require 'nokogiri'
require 'open-uri'
require 'csv'

# 1. Welcome
puts "\n"
puts "*" * 31
puts "*" + " " * 29 + "*"
puts "*  Welcome to Christmas List  *"
puts "*" + " " * 29 + "*"
puts "*" * 31

# Create gift_list (what data structe?)
gift_list = []
# Code the action

action = "whaever value"

# 4. Perform the right action
until action == "quit"
  # 2. Display menu (list / add / delete / mark )
  puts "What do you want to do? [ list / add / delete / mark / idea / quit ]"

  # 3. Get user action
  action = gets.chomp

  case action
  when "list"
    # access gift_list and display all the gifts
    # i.e 1- PS5
    gift_list.each_with_index do |gift, index|
      # codition ? code_if_thrufy : code_if_falsey
      status = gift[:bought] ? "[x]" : "[ ]"

      puts "#{index + 1} #{status} - #{gift[:name]} - Price #{gift[:price]}"
    end

  when "add"

    # gift_list = [
    #   {name: 'Chocolate', price: 16, bought: false},
    #   {name: 'PS5', price: 400, bought: false}
    # ]

    # ask the user what wants to add
    puts "What gift do you want to add to the list?"
    name_input = gets.chomp

    puts "And how much does it cost?"
    price_input = gets.chomp.to_i
    # add to gift list
    gift_list << {name: name_input, price: price_input, bought: false}

  when "delete"
    gift_list.each_with_index do |gift, index|
      # codition ? code_if_thrufy : code_if_falsey
      status = gift[:bought] ? "[x]" : "[ ]"

      puts "#{index + 1} #{status} - #{gift[:name]} - Price #{gift[:price]}"
    end
    # ask user what want to delete
    puts "What gift do you want to delete from the list? (number in the list)"
    user_input = gets.chomp.to_i
    # delete it from gift list
    gift_list.delete_at(user_input - 1)

  when "mark"
    # diplay the list
    gift_list.each_with_index do |gift, index|
      # codition ? code_if_thrufy : code_if_falsey
      status = gift[:bought] ? "[x]" : "[ ]"

      puts "#{index + 1} #{status} - #{gift[:name]} - Price #{gift[:price]}"
    end
    # ask which one wants to mark
    puts "Which one you want to mark as bought? (number in the list)"
    # get input from user
    user_input = gets.chomp.to_i
    # update the value of bought
    gift_list[user_input - 1][:bought] = true

  when "idea"

    puts "What are you searching on Etsy?"
    article = gets.chomp

    # 1. We get the HTML page content thanks to open-uri
    html_content = URI.open("https://www.etsy.com/search?q=#{article}").read

    # filepath = "result.html"
    # # 1. We get the HTML page content
    # html_content = File.open(filepath)
    # 2. We build a Nokogiri document from this file
    doc = Nokogiri::HTML(html_content)

    results = []
    # 3. We search for the correct elements containing the items' title in our HTML doc
    doc.search('.v2-listing-card .v2-listing-card__info .text-body').first(5).each do |element|
      # 4. For each item found, we extract its title and print it
      results << element.text.strip
    end

    results.each_with_index do |element, index|
      puts "#{index + 1} - #{element}"
    end

    puts "Which one do you want to add to the list?"
    user_input = gets.chomp.to_i

    gift_list << { name: results[user_input - 1], price: "unsure", bought: false }

    puts "#{results[user_input - 1]} was added to your list!"
  when "quit"
    puts "Goodbye"
  else
    puts "not a valid option"
  end
end


# 1. update the user options

# 2. update gift_list (decide the structure)
# gift_list = [
  # {'ps5' => {price: 10, bought: true}}
#]

# 3. update all the actions for new gift_list structure

# gift_list = [
#   {name: 'Chocolate', price: 16, bought: false},
#   {name: 'PS5', price: 400, bought: false}
# ]

# name = gets.chomp
# price = gets.chomp.to_i


# carlas_gift = { name: name, price: price, bought: false }

# 1. need to access the right url (first via filepath after via open URI)
# 2. select the name of 5 the products
# 3. diplay the names to the user
# 4. ask the user which one wants to add to the list
# 5. add the selected one to the list

csv_options = { col_sep: ',', force_quotes: true, quote_char: '"' }
filepath    = 'gifts.csv'

CSV.open(filepath, 'wb', csv_options) do |csv|
  # We had headers to the CSV
  csv << ['name', 'price', 'bought']
  #TODO: store each gift
  gift_list.each do |gift|
    csv << [ gift[:name], gift[:price], gift[:bought] ]
  end
end
