require 'account/client'
require 'account/client/controls'

account_id = Identifier::UUID::Random.get
amount = Account::Client::Controls::Money.example

Account::Client::Withdraw.(
  account_id: account_id,
  amount: amount
)

stream_name = Messaging::StreamName.stream_name(account_id, 'account')

sleep 1

withdrawal_rejected_data = MessageStore::Postgres::Get::Stream::Last.(stream_name)

pp withdrawal_rejected_data
