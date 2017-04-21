require_relative './exercise_init'

account_id = Identifier::UUID::Random.get

event_stream_name = "account-#{account_id}"
command_stream_name = "account:command-#{account_id}"

store = Store.build


# Write deposited to event stream
deposited = Messages::Events::Deposited.new
deposited.account_id = account_id
deposited.amount = 11
deposited.time = '2000-01-01T11:11:11.000Z'

Messaging::Postgres::Write.(deposited, event_stream_name)

account = store.fetch(account_id)
puts "Account #{account_id} balance: $#{account.balance}"


# Write withdraw to command stream
withdraw = Messages::Commands::Withdraw.new
withdraw.account_id = account_id
withdraw.amount = 12
withdraw.time = '2000-01-01T11:11:11.000Z'

Messaging::Postgres::Write.(withdraw, command_stream_name)


# Handle withdraw
MessageStore::Postgres::Read.(command_stream_name) do |message_data|
  Handlers::Commands.(message_data)
end


account = store.fetch(account_id)
puts "Account #{account_id} balance: $#{account.balance}"
