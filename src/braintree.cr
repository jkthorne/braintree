require "http/client"
require "json"

require "habitat"
require "dotenv"

require "./models"
require "./operations"

Dotenv.load ".env"

module Braintree
  Habitat.create do
    setting host : String = "https://payments.sandbox.braintree-api.com/graphql"
    setting api_token : String
  end

  class Operation
    getter http : HTTP::Client::Response
    getter page_info : Models::PageInfo?

    def initialize(@http, @page_info = nil)
    end
  end

  def self.charge(*args, **params)
    query = Operations::ChargePaymentMethod.new(*args, **params)
    response = gql_request(query)

    if response.success?
      puts response.body

      gql_object = Models::TransactionResult.from_json(response.body)
      opertion = Operation.new(response)

      yield opertion, gql_object.data.charge_payment_method.transaction
    else
      yield Operation.new(response), nil
    end
  end

  def self.transaction_search(*args, **params)
    query = Operations::TransactionSearch.new(*args, **params)
    response = gql_request(query)

    if response.success?
      gql_object = Models::TransactionSearchResult.from_json(response.body)
      opertion = Operation.new(response, gql_object.data.search.transactions.page_info)

      model = gql_object.data.search.transactions.edges.map do |edge|
        edge.node
      end

      yield opertion, model
    else
      yield Operation.new(response), nil
    end
  end

  private def self.gql_request(query)
    HTTP::Client.post(
      Braintree.settings.host,
      headers: HTTP::Headers{
        "Authorization" => Braintree.settings.api_token,
        "Braintree-Version" => "2019-01-01",
        "Content-Type" => "application/json"
      },
      body: query.to_gql
    )
  end
end

Braintree.configure do |settings|
  settings.api_token = ENV.fetch("BRAINTREE_AUTH")
end

Braintree.charge("fake-valid-nonce", "123.45") do |operation, transaction|
  if transaction
    puts transaction.id
    puts transaction.status
  else
    puts "ERROR #{operation}"
  end
end

# Braintree.transaction_search(
#   page_info: true,
#   input_amount_value: {"greaterThanOrEqualTo" => "10.00"},
#   input_status: ["SETTLED", "VOIDED"]) do |operation, transactions|
#   if transactions # the operation was successful
#     puts transactions
#   else
#     puts "ERROR #{operation}"
#   end
# end
