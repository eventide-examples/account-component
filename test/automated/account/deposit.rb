require_relative '../automated_init'

context "Account" do
  context "Deposit" do
    account = Controls::Account::Balance.example
    prior_balance = account.balance

    amount = Controls::Money.example

    account.deposit(amount)

    test "Balance is increased by amount" do
      assert(account.balance == prior_balance + amount)
    end
  end
end
