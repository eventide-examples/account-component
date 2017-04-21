require_relative '../automated_init'

context "Account" do
  context "Withdraw" do
    account = Controls::Account::Balance.example
    prior_balance = account.balance

    amount = Controls::Money.example

    account.withdraw(amount)

    test "Balance is decreased by amount" do
      assert(account.balance == prior_balance - amount)
    end
  end
end
