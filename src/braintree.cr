require "log"
require "http/client"
require "json"
require "xml"
require "csv"

require "gql"
require "tablo"

require "./config"
require "./constants"
require "./xml_builder"
require "./models"
require "./operations"
require "./queries"

module Braintree
  @@config : BT::Config?

  def self.config(profile = "default")
    @@config ||= Config.new(profile)
  end

  @@home_dir : Path?

  def self.home_dir
    Path.home
  end

  @@data_dir : Path?

  def self.data_dir
    @@data_dir ||= begin
      path = home_dir / ".local" / "share" / "bt"
      FileUtils.mkdir_p(path.to_s) if !File.exists?(path.to_s)
      path
    end
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
    @@auth_toket ||= Base64.strict_encode(config.public_key + ':' + config.private_key)
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

  @@client : HTTP::Client?

  def self.http
    @@client ||= begin
      client = HTTP::Client.new config.host
      client.before_request do |request|
        request.headers["Authorization"] = "Bearer #{Braintree.auth_token}"
        request.headers["x-apiversion"] = "6"
        request.headers["User-Agent"] = "Totally Unoffical Crystal Client / #{Braintree::VERSION}"
        request.headers["Accept"] = "application/xml"
        request.headers["Content-Type"] = "application/xml" unless request.headers["Content-Type"]?
        request.headers.each { |h| Log.debug { h } }
        Log.debug { request.body }
      end
      client
    end
  end

  def self.xml
    XML.build(version: "1.0", encoding: "UTF-8") do |xml|
      XMLBuilder.build(xml) do |tb|
        yield tb
      end
    end
  end
end

alias BT = Braintree
