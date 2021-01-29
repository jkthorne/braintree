class Braintree::Queries::Dispute::Search < BTQ::Query
  private getter options : Hash(Symbol, String)
  private getter page_num : Int32

  def initialize(@options, @page_num)
  end

  def exec
    response = Braintree.http.post(
      path: "/merchants/#{BT.settings.merchant}/disputes/advanced_search?page=#{page_num}",
      body: XML.build { |t|
        t.element("search") {
          t.element("kind", type: "array") {
            t.element("item") { t.text "chargeback" }
          }
        }
      }
    )

    yield response, response.success? ? Models::Disputes.new(XML.parse(response.body)) : nil
  end
end
