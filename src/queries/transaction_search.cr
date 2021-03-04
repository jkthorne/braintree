class Braintree::TransactionSearch < Braintree::Query
  getter amount : Hash(String, String)?
  getter status : Array(Symbol)?
  getter page_info = false
  getter transaction_fields : Array(Symbol)

  def initialize(@transaction_fields, @amount = nil, @status = nil, @page_info = false)
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
      io << "query Search($input: TransactionSearchInput!) {"
      io << "search { transactions(input: $input) {"
      io << "pageInfo { hasNextPage startCursor endCursor }," if page_info
      io << "edges { node { "
      transaction_fields.each do |field|
        if field == :amount
          io << "amount { value currencyIsoCode } "
          next
        end
        io << field
        io << ' '
      end
      io << "} } } } }"
    end
  end

  def variables_builder(json)
    json.field "input" do
      json.object do
        if !amount.nil?
          json.field "amount" do
            json.object do
              json.field "value" do
                json.object do
                  amount.not_nil!.each do |key, value|
                    json.field key, value
                  end
                end
              end
            end
          end
        end
        if !status.nil?
          json.field "status" do
            json.object do
              json.field "in", status
            end
          end
        end
      end
    end
  end
end
