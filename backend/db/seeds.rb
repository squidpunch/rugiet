# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Clear existing currencies
Currency.destroy_all

# Seed currencies
currencies_data = {
  "AUD" => "Australian Dollar",
  "BGN" => "Bulgarian Lev",
  "BRL" => "Brazilian Real",
  "CAD" => "Canadian Dollar",
  "CHF" => "Swiss Franc",
  "CNY" => "Chinese Renminbi Yuan",
  "CZK" => "Czech Koruna",
  "DKK" => "Danish Krone",
  "EUR" => "Euro",
  "GBP" => "British Pound",
  "HKD" => "Hong Kong Dollar",
  "HUF" => "Hungarian Forint",
  "IDR" => "Indonesian Rupiah",
  "ILS" => "Israeli New Shekel",
  "INR" => "Indian Rupee",
  "ISK" => "Icelandic Króna",
  "JPY" => "Japanese Yen",
  "KRW" => "South Korean Won",
  "MXN" => "Mexican Peso",
  "MYR" => "Malaysian Ringgit",
  "NOK" => "Norwegian Krone",
  "NZD" => "New Zealand Dollar",
  "PHP" => "Philippine Peso",
  "PLN" => "Polish Złoty",
  "RON" => "Romanian Leu",
  "SEK" => "Swedish Krona",
  "SGD" => "Singapore Dollar",
  "THB" => "Thai Baht",
  "TRY" => "Turkish Lira",
  "USD" => "United States Dollar",
  "ZAR" => "South African Rand"
}

currencies_data.each do |code, name|
  Currency.create!(code: code, name: name)
end

puts "Created #{Currency.count} currencies"
