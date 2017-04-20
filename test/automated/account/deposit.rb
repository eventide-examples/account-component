require_relative '../automated_init'

context "Account" do
  context "Deposit" do
    account = Account.new
    account.balance = 1

    amount = 11

    account.deposit(amount)

    test "Balance is increased by amount" do
      assert(account.balance == 12)
    end
  end
end
