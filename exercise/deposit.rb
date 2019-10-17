require_relative './exercise_init'

account_id = Identifier::UUID::Random.get

deposit = Messages::Commands::Deposit.new
deposit.account_id = account_id
deposit.amount = 11
deposit.time = '2000-01-01T11:11:11.000Z'

command_stream_name = "account:command-#{account_id}"

Messaging::Postgres::Write.(deposit, command_stream_name)

MessageStore::Postgres::Read.(command_stream_name) do |message_data|
  Handlers::Commands.(message_data)
end
