require_relative './exercise_init'

account_id = Identifier::UUID::Random.get

stream_name = "account-#{account_id}"

deposited = Messages::Events::Deposited.new
deposited.account_id = account_id
deposited.time = '2000-01-01T11:11:11.000Z'
deposited.processed_time = '2000-01-01T22:22:22.000Z'

store = Store.build


account = store.fetch(account_id)
puts "Account #{account_id} balance: $#{account.balance}"


deposited.amount = 1
Messaging::Postgres::Write.(deposited, stream_name)

deposited.amount = 11
Messaging::Postgres::Write.(deposited, stream_name)

deposited.amount = 111
Messaging::Postgres::Write.(deposited, stream_name)


account = store.fetch(account_id)
puts "Account #{account_id} balance: $#{account.balance}"


deposited.amount = 1111
Messaging::Postgres::Write.(deposited, stream_name)


account = store.fetch(account_id)
puts "Account #{account_id} balance: $#{account.balance}"


withdrawn = Messages::Events::Withdrawn.new
withdrawn.account_id = account_id
withdrawn.time = '2000-01-01T11:11:11.000Z'
withdrawn.processed_time = '2000-01-01T22:22:22.000Z'
withdrawn.amount = 1111

Messaging::Postgres::Write.(withdrawn, stream_name)


account = store.fetch(account_id)
puts "Account #{account_id} balance: $#{account.balance}"
