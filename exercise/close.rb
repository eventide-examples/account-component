require_relative './exercise_init'

account_id = Identifier::UUID::Random.get

close = Messages::Commands::Close.new
close.account_id = account_id
close.time = '2000-01-01T11:11:11.000Z'

command_stream_name = "account:command-#{account_id}"

# Write close command
Messaging::Postgres::Write.(close, command_stream_name)

# Write close command again
Messaging::Postgres::Write.(close, command_stream_name)

# Handle both commands
MessageStore::Postgres::Read.(command_stream_name) do |message_data|
  Handlers::Commands.(message_data)
end
