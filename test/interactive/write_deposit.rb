require_relative './interactive_init'

deposit_id = Identifier::UUID::Random.get

account_id = '123'

amount = 11

Controls::Write::Deposit.(
  id: deposit_id,
  account_id: account_id,
  amount: amount
)
