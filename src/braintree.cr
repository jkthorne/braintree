require "http/client"
require "json"

require "habitat"
require "dotenv"

Dotenv.load ".env"

module Braintree
  Habitat.create do
    setting host : String = "https://payments.sandbox.braintree-api.com/graphql"
    setting api_token : String
  end

  def self.search_transaction(**params)
    txs = TransactionSearch.new(**params)

    response = HTTP::Client.post(
      Braintree.settings.host,
      headers: HTTP::Headers{
        "Authorization" => Braintree.settings.api_token,
        "Braintree-Version" => "2019-01-01",
        "Content-Type" => "application/json"
      },
      body: txs.to_gql
    )

    if response.success?
      json = Braintree::TransactionResult.from_json(response.body)
      object = json.data.search.transactions
    end

    # yield operation, transactions
    yield response, object
  end

  class Query
    def self.to_gql
      String.build do |str|
        str << "query { "
        yield str
        str << " }"
      end
    end
  end

  class Ping < Query
    def self.to_gql
      super do |io|
        io << "ping"
      end
    end
  end

  class Disputes < Query

  end

  class TransactionSearch < Query
    getter page_info = false
    getter id = true
    getter status = true
    getter amount = true
    getter input_amount_value : Hash(String, String)?
    getter input_status : Array(String)?

    def initialize(@page_info = false, @id = true, @status = true, @amount = true, @input_amount_value = nil, @input_status = nil)
    end

    def to_gql
      JSON.build do |json|
        json.object do
          json.field "query", query_string
          json.field "variables" do
            json.object do
              variables_builder(json)
            end
          end
        end
      end
    end

    private def query_string
      String.build do |io|
        io << %(
          query Search($input: TransactionSearchInput!) {
            search {
              transactions(input: $input) {
        )
        if page_info
          io << %(
            pageInfo {
              hasNextPage
              startCursor
              endCursor
            },
          )
        end
        io << %(
          edges {
            node {
        )
        io.puts "id" if id
        io.puts "status\n" if status
        if amount
          io << %(
            amount {
              value
              currencyIsoCode
            }
          )
        end
        io << %(
                }
              }
            }
          }
        )
        io << " }"
      end
    end

    def variables_builder(json)
      json.field "input" do
        json.object do
          if !input_amount_value.nil?
            json.field "amount" do
              json.object do
                json.field "value" do
                  json.object do
                    input_amount_value.not_nil!.each do |key, value|
                      json.field key, value
                    end
                  end
                end
              end
            end
          end
          if !input_status.nil?
            json.field "status" do
              json.object do
                json.field "in", input_status
              end
            end
          end
        end
      end
    end
  end

  class TransactionResult
    include JSON::Serializable
    class Data
      include JSON::Serializable
      class Search
        include JSON::Serializable
        class Transactions
          include JSON::Serializable
          class PageInfo
            include JSON::Serializable

            @[JSON::Field(key: "hasNextPage")]
            property has_next_page : Bool

            @[JSON::Field(key: "startCursor")]
            property start_cursor : String

            @[JSON::Field(key: "endCursor")]
            property end_cursor : String
          end

          class Edges
            include JSON::Serializable

            class Node
              include JSON::Serializable

              class Amount
                include JSON::Serializable

                @[JSON::Field(key: "value")]
                property value : String
                @[JSON::Field(key: "currencyIsoCode")]
                property currency_iso_code : String
              end

              @[JSON::Field(key: "id")]
              property id : String
              @[JSON::Field(key: "status")]
              property status : String
              @[JSON::Field(key: "amount")]
              property amount : Amount
            end

            @[JSON::Field(key: "node")]
            property node : Node
          end

          @[JSON::Field(key: "pageInfo")]
          property page_info : PageInfo

          @[JSON::Field(key: "edges")]
          property edges : Array(Edges)
        end

        @[JSON::Field(key: "transactions")]
        property transactions : Transactions
      end

      @[JSON::Field(key: "search")]
      property search : Search
    end

    class Extensions
      include JSON::Serializable

      @[JSON::Field(key: "requestId")]
      property request_id : String
    end

    @[JSON::Field(key: "data")]
    property data : Data
    @[JSON::Field(key: "extensions")]
    property extensions : Extensions
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
