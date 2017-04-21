require_relative '../automated_init'

context "Account" do
  context "Has Opened Time" do
    account = Controls::Account::Open.example

    test "Is open" do
      assert(account.open?)
    end
  end

  context "Does not Have Opened Time" do
    account = Controls::Account::New.example

    test "Is not opened" do
      refute(account.open?)
    end
  end
end
