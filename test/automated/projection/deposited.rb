require_relative '../automated_init'

context "Projection" do
  context "Deposited" do
    account = Account.new
    account.balance = 1

    account_id = Identifier::UUID::Random.get

    deposited = Messages::Events::Deposited.new
    deposited.account_id = account_id
    deposited.amount = 11

    Projection.(account, deposited)

    test "Account balance is increased" do
      assert(account.balance == 12)
    end

    context "Attributes"do
      test "account_id" do
        assert(account.id == account_id)
      end
    end
  end
end
