require_relative '../automated_init'

context "Account" do
  context "Withdraw" do
    account = Account.new
    account.balance = 11

    amount = 1

    account.withdraw(amount)

    test "Balance is increased by amount" do
      assert(account.balance == 10)
    end
  end
end
