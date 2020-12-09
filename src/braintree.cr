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

  def self.search_transaction(**params)
    query = TransactionSearch.new(**params)
    response = gql_request(query)

    if response.success?
      gql_object = GQLResult.from_json(response.body)
      opertion = Operation.new(response, gql_object.data.search.transactions.page_info)
      model = gql_object.data.search.transactions.edges

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

Braintree.search_transaction(
  page_info: true,
  input_amount_value: {"greaterThanOrEqualTo" => "10.00"},
  input_status: ["SETTLED", "VOIDED"]) do |operation, transactions|
  if transactions # the operation was successful
    puts transactions
  else
    puts "ERROR #{operation}"
  end
end
