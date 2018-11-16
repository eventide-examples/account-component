require_relative './client_exercise_init'

account_id = Identifier::UUID::Random.get

class SomeMessage
  include Messaging::Message
end

some_message = SomeMessage.new

metadata = some_message.metadata
metadata.source_message_stream_name = 'someMessage-some_id'
metadata.source_message_position = 111

Account::Client::Withdraw.(
  account_id: account_id,
  amount: 11,
  previous_message: some_message
)

account_command_stream_name = "account:command-#{account_id}"

MessageStore::Postgres::Read.(account_command_stream_name) do |message_data|
  pp message_data
end
