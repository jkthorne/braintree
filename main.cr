require "./src/braintree"

Braintree.configure do |settings|
  settings.merchant = ENV.fetch("BT_MERCHANT")
  settings.public_key = ENV.fetch("BT_PUBLIC_KEY")
  settings.private_key = ENV.fetch("BT_PRIVATE_KEY")
end

date = Time.utc.shift years: 1
expiration_date = "%02d/%s" % [date.month, date.year]

BT::Transaction.create(
  amount: "#{rand(12..10_000)}.12",
  credit_card: {
    number: Braintree::Test::CreditCardNumbers::Disputes::CHARGEBACK,
    expiration_date: expiration_date,
  }
) do |operation, tx|
  if tx
    pp tx
  else
    puts "Failed to create"
  end
end
