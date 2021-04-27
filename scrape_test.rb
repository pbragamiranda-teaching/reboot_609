require 'nokogiri'

filepath = "result.html"
# 1. We get the HTML page content
html_content = File.open(filepath)
# 2. We build a Nokogiri document from this file
doc = Nokogiri::HTML(html_content)

results = []
# 3. We search for the correct elements containing the items' title in our HTML doc
doc.search('.v2-listing-card .v2-listing-card__info .text-body').first(5).each do |element|
  # 4. For each item found, we extract its title and print it
  results << element.text.strip
  # puts element.text.strip
end

results.each_with_index do |element, index|
  puts "#{index + 1} - #{element}"
end

puts "Which one do you want to add to the list?"
user_input = gets.chomp.to_i

puts results[user_input - 1]
