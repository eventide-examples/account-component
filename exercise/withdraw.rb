require_relative './exercise_init'

account_id = Identifier::UUID::Random.get

withdraw = Messages::Commands::Withdraw.new
withdraw.account_id = account_id
withdraw.amount = 11
withdraw.time = '2000-01-01T11:11:11.000Z'

command_stream_name = "account:command-#{account_id}"

Messaging::Postgres::Write.(withdraw, command_stream_name)

MessageStore::Postgres::Read.(command_stream_name) do |message_data|
  Handlers::Commands.(message_data)
end

stream_name = "account-#{account_id}"

MessageStore::Postgres::Read.(stream_name) do |message_data|
  pp message_data.data
end
