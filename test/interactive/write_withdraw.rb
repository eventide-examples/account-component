require_relative './interactive_init'

withdrawal_id = Identifier::UUID::Random.get

account_id = '123'

amount = 11

Controls::Write::Withdraw.(
  id: withdrawal_id,
  account_id: account_id,
  amount: amount
)
