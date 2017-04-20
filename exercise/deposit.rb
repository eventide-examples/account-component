require_relative './exercise_init'

deposit = Messages::Commands::Deposit.new
deposit.account_id = '123'
deposit.amount = 11
deposit.time = '2000-01-01T11:11:11.000Z'

command_stream_name = 'account:command-123'

Messaging::Postgres::Write.(deposit, command_stream_name)

# TODO: Read stream and handle each command message
