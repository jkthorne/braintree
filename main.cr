require "./src/braintree"

Braintree.configure do |settings|
  settings.merchant = ENV.fetch("BT_MERCHANT")
  settings.public_key = ENV.fetch("BT_PUBLIC_KEY")
  settings.private_key = ENV.fetch("BT_PRIVATE_KEY")
end