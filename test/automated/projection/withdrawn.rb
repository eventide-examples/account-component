require_relative '../automated_init'

context "Projection" do
  context "Withdrawn" do
    account = Account.new
    account.balance = 11

    account_id = Identifier::UUID::Random.get

    withdrawn = Messages::Events::Withdrawn.new
    withdrawn.account_id = account_id
    withdrawn.amount = 1

    Projection.(account, withdrawn)

    test "Account balance is decreased" do
      assert(account.balance == 10)
    end

    context "Attributes"do
      test "account_id" do
        assert(account.id == account_id)
      end
    end
  end
end
