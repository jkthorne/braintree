module Braintree::Operations
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
        io << "\nid\n" if id
        io << "\nstatus\n" if status
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
end
