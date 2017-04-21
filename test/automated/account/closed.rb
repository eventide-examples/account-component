require_relative '../automated_init'

context "Account" do
  context "Has Closed Time" do
    account = Controls::Account::Closed.example

    test "Is closed" do
      assert(account.closed?)
    end
  end

  context "Does not Have Closed Time" do
    account = Controls::Account.example

    test "Is not closed" do
      refute(account.closed?)
    end
  end
end
