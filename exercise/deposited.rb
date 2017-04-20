ENV['LOG_TAGS'] ||= 'messaging'

require_relative './exercise_init'

deposited = Messages::Events::Deposited.new
deposited.account_id = '123'
deposited.amount = 11
deposited.time = '2000-01-01T11:11:11.000Z'
deposited.processed_time = '2000-01-01T22:22:22.000Z'

stream_name = 'account-123'

Messaging::Postgres::Write.(deposited, stream_name)

# TODO: Read stream and print each message using pp
