require_relative './exercise_init'

account_id = Identifier::UUID::Random.get

account = Account.new
account.id = account_id
account.balance = 1

puts "Account #{account.id} balance: $#{account.balance}"

amount = 11
puts "Deposit $#{amount} to account #{account.id}"
account.deposit(amount)

puts "Account #{account.id} balance: $#{account.balance}"

amount = 22
puts "Deposit $#{amount} to account #{account.id}"
account.deposit(amount)

puts "Account #{account.id} balance: $#{account.balance}"
