require "log"
require "http/client"
require "json"
require "xml"
require "csv"

require "habitat"
require "dotenv"
require "gql"
require "factory" # TODO: remove
require "tablo"

require "./constants"
require "./xml_builder"
require "./models"
require "./operations"
require "./queries"

module Braintree
  Habitat.create do
    setting host : URI = URI.parse("https://api.sandbox.braintreegateway.com:443/")
    setting public_key : String
    setting private_key : String
    setting merchant : String
  end

  def self.home_dir
    Path.home
  end

  @@home_dir : Path?

  def self.config_dir
    @@home_dir ||= begin
      path = home_dir / ".config" / "bt"
      FileUtils.mkdir_p(path.to_s) if !File.exists?(path.to_s)
      path
    end
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

  @@client : HTTP::Client?

  def self.http
    @@client ||= begin
      client = HTTP::Client.new settings.host
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

  def self.setup_config(profile = "default")
    path = (config_dir / "#{profile}.ini").expand(home: true)

    Braintree.configure do |settings|
      print "Enter merchant id: "
      settings.merchant = gets.to_s
      print "Enter public key: "
      settings.public_key = gets.to_s
      print "Enter private key: "
      settings.private_key = gets.to_s
    end

    File.write(path.to_s, INI.build({"braintree" => Braintree.settings.to_h}))

    true
  end

  def self.load_env_file
    if File.exists?(ENV_FILE)
      Dotenv.load(ENV_FILE)

      Braintree.configure do |settings|
        settings.merchant = ENV.fetch("BT_MERCHANT")
        settings.public_key = ENV.fetch("BT_PUBLIC_KEY")
        settings.private_key = NEV.fetch("BT_PRIVATE_KEY")
      end

      true
    else
      false
    end
  end

  def self.load_config(profile = "default")
    path = (config_dir / "#{profile}.ini").expand(home: true)

    if File.exists?(path.to_s)
      config = INI.parse(File.read(path.to_s))

      Braintree.configure do |settings|
        settings.merchant = config.dig("braintree", "merchant")
        settings.public_key = config.dig("braintree", "public_key")
        settings.private_key = config.dig("braintree", "private_key")
      end

      true
    else
      setup_config(profile)
    end
  end

  def self.push_config(merchant = nil, public_key = nil, private_key = nil, profile = "default")
    path = (config_dir / "#{profile}.ini").expand(home: true)
    config = {} of String => String

    config["merchant"] = merchant || settings.merchant
    config["public_key"] = public_key || settings.public_key
    config["private_key"] = private_key || settings.private_key

    File.write(path.to_s, INI.build({"braintree" => config}))

    true
  end
end

alias BT = Braintree
