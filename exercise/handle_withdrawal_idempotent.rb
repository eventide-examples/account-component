require_relative './exercise_init'

account_id = Identifier::UUID::Random.get


deposited = Messages::Events::Deposited.new
deposited.account_id = account_id
deposited.amount = 100
deposited.time = '2000-01-01T11:11:11.000Z'
deposited.processed_time = '2000-01-01T22:22:22.000Z'
deposited.sequence = 0

Messaging::Postgres::Write.(deposited, "account-#{account_id}")


withdraw = Messages::Commands::Withdraw.new
withdraw.account_id = account_id
withdraw.amount = 11
withdraw.time = '2000-01-01T11:11:11.000Z'

command_stream_name = "account:command-#{account_id}"


store = Store.build


Messaging::Postgres::Write.(withdraw, command_stream_name)

MessageStore::Postgres::Read.(command_stream_name) do |message_data|
  Handlers::Commands.(message_data)
end


account = store.fetch(account_id)
puts "Account #{account_id} balance: $#{account.balance}"


MessageStore::Postgres::Read.(command_stream_name) do |message_data|
  Handlers::Commands.(message_data)
end


account = store.fetch(account_id)
puts "Account #{account_id} balance: $#{account.balance}"
