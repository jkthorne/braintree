# require "./src/braintree"

# Braintree.configure do |settings|
#   settings.merchant = ENV.fetch("BT_MERCHANT")
#   settings.public_key = ENV.fetch("BT_PUBLIC_KEY")
#   settings.private_key = ENV.fetch("BT_PRIVATE_KEY")
# end

require "xml"
require "json"

require "habitat"
require "dotenv"
require "gql"
require "factory"

require "./src/models"

Braintree::Transaction.new(
  XML.parse(File.read("./spec/fixtures/create_transaction.xml"))
).disputes.first.store
