require_relative './exercise_init'

account = Account.new
account.id = '123'
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
