require_relative './exercise_init'

account_id = Identifier::UUID::Random.get

withdrawn = Messages::Events::Withdrawn.new
withdrawn.account_id = account_id
withdrawn.amount = 11
withdrawn.time = '2000-01-01T11:11:11.000Z'
withdrawn.processed_time = '2000-01-01T22:22:22.000Z'

stream_name = "account-#{account_id}"

Messaging::Postgres::Write.(withdrawn, stream_name)

account = Account.new

puts "Account balance: $#{account.balance}"

MessageStore::Postgres::Read.(stream_name) do |message_data|
  Projection.(account, message_data)
end

puts "Account balance: $#{account.balance}"
