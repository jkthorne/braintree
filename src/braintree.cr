require "http/client"
require "json"
require "xml"

require "habitat"
require "dotenv"
require "gql"

require "./constants"
require "./models"
require "./operations"

## TODO: remove for config file
Dotenv.load ".env"

module Braintree
  Habitat.create do
    setting host : URI = URI.parse("https://api.sandbox.braintreegateway.com:443/")
    setting public_key : String
    setting private_key : String
    setting merchant : String
  end

  @@graph_host : URI?
  def self.graph_host
    @@graph_host ||= begin
      host = settings.host.dup
      host.path = "/graphql"
      host
    end
  end

  def self.host(path)
    host = settings.host.dup
    host.path = path
    host
  end

  @@auth_token : String?
  def self.auth_token
    @@auth_toket ||= Base64.strict_encode(settings.public_key + ':' + settings.private_key)
  end

  class Operation
    getter http : HTTP::Client::Response
    getter page_info : Models::PageInfo?

    def initialize(@http, @page_info = nil)
    end
  end

  def self.charge(*args, **params)
    query = Operations::ChargePaymentMethod.new(*args, **params)
    response = gql(query)

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
    response = gql(query)

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

  def self.gql(query)
    HTTP::Client.post(
      graph_host,
      headers: HTTP::Headers{
        "Authorization"     => "Bearer #{Braintree.auth_token}",
        "Braintree-Version" => "2019-01-01",
        "Content-Type"      => "application/json",
        "User-Agent"        => "Totally Unoffical Crystal Client / 0.1",
      },
      body: query.to_gql
    )
  end

  def self.http(path, body)
    HTTP::Client.post(
      host(path),
      headers: HTTP::Headers{
        "Authorization"     => "Bearer #{Braintree.auth_token}",
        "x-apiversion"      => "6",
        "User-Agent"        => "Totally Unoffical Crystal Client / 0.1",
        "Accept"            => "application/json",
        "Content-Type"      => "application/xml",
        },
      body: body
    )
  end

  def self.transaction_xml
    XML.build(version: "1.0", encoding: "UTF-8") do |xml|
      Transaction::XMLBuilder.build(xml) do |tb|
        yield tb
      end
    end
  end

  def self.transaction(**kargs)
    Transaction.new(**kargs)
  end
end

alias BT = Braintree