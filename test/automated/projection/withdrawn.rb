require_relative '../automated_init'

context "Projection" do
  context "Withdrawn" do
    withdrawn = Controls::Events::Withdrawn.example

    context do
      account = Controls::Account::Balance.example
      prior_balance = account.balance

      Projection.(account, withdrawn)

      test "Account balance is decreased" do
        assert(account.balance == prior_balance - withdrawn.amount)
      end
    end

    context "ID Is Set" do
      account = Controls::Account::New.example

      assert(account.id.nil?)
      account_id = withdrawn.account_id or fail

      Projection.(account, withdrawn)

      test do
        assert(account.id == account_id)
      end
    end
  end
end
