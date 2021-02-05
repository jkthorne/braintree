class Braintree::Queries::Dispute::Search < BTQ::Query
  private getter options : Hash(Symbol, String)

  def initialize(@options)
    # TODO: validate and split out cli options
    # TODO: build page info
  end

  def exec
    uri = URI.new
    uri.path = "/merchants/#{BT.settings.merchant}/disputes/advanced_search"
    params = URI::Params.new
    params["page"] = options[:page_num]? ? options[:page_num] : "1"
    uri.query_params = params

    response = Braintree.http.post(
      path: uri.request_target,
      body: search_params
    )

    yield response, response.success? ? Models::Disputes.new(XML.parse(response.body)) : nil
  end

  def search_params
    @seach_params ||= XML.build do |xml|
      xml.element("search") {
        search_params_amount(xml)
        search_params_status(xml)
        search_params_kind(xml)
      }
    end
  end

  def search_params_amount(xml)
    if options[:amounts]?
      min, max = options[:amounts].split(",")
      raise "amount format invalid" if min == nil || max == nil

      xml.element("amount-disputed") {
        xml.element("min") { xml.text min }
        xml.element("max") { xml.text max }
      }
    end
  end

  def search_params_status(xml)
    if options[:status]?
      statuses = options[:status].split(",")
      statuses.each do |s|
        raise "invalid status #{s}" unless BT::Models::Dispute::Status::ALL.includes?(s)
      end

      xml.element("status", type: "array") {
        statuses.each { |status| xml.element("item") { xml.text status } }
      }
    end
  end

  def search_params_kind(xml)
    if options[:kind]?
      kinds = options[:kind].split(",")
      kinds.each do |k|
        raise "invalid kind #{k}" unless BT::Models::Dispute::Kind::ALL.includes?(k)
      end

      xml.element("kind", type: "array") {
        kinds.each { |kind| xml.element("item") { xml.text kind } }
      }
    end
  end
end
