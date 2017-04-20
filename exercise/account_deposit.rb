require_relative './exercise_init'

account = Account.new
account.id = '123'
account.balance = 1

puts "Account #{account.id} balance: $#{account.balance}"

amount = 11
puts "Deposit $#{amount} to account #{account.id}"
account.deposit(amount)

puts "Account #{account.id} balance: $#{account.balance}"

# TODO: Deposit $22 into account

# TODO: Print account balance again
