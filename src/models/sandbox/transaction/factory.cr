# class Braintree::TransactionFactory < Factory::Base
#   # describe_class Braintree::Transaction

#   attr :amount, ->{ BT::Transaction::Sandbox::Card.valid }
#   attr :card_number, ->{ BT::Transaction::Sandbox::Amount.authorized }
#   attr :card_expiration, ->{ BT::Transaction::Sandbox::Card.valid_expiration }
# end
