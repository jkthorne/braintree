module Braintree::Operations
  class Query
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
  end

  class Mutation
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
  end

  class Operation
    getter request : HTTP::Request? ## TODO remove nil
    getter response : HTTP::Client::Response?

    def success?
      response.try &.success?
    end

    # def self.exec(*args, **kargs)
    #   new(*args, **kargs).exec do |op, tx|
    #     yield op, tx
    #   end
    # end
  end

  # abstract class Operation
  #   private getter state : State

  #   def initialize
  #     @state = State.new
  #     @state.operation = self
  #   end
  
  #   def self.exec(*args, **kargs)
  #     new(*args, **kargs).exec do |op, tx|
  #       yield op, tx
  #     end
  #   end
  # end

  class State
    property operation : BTO::Operation?
    property request : HTTP::Request?
    property response : HTTP::Client::Response?

    def success?
      response.try &.success?
    end
  end
end

alias BTO = Braintree::Operations

require "./operations/**"
