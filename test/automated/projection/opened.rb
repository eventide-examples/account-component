require_relative '../automated_init'

context "Projection" do
  context "Opened" do
    account = Controls::Account::New.example

    assert(account.opened_time.nil?)

    opened = Controls::Events::Opened.example

    customer_id = opened.customer_id or fail
    account_id = opened.account_id or fail

    Projection.(account, opened)

    test "ID is set" do
      assert account.id == account_id
    end

    test "Customer ID is set" do
      assert(account.customer_id == customer_id)
    end

    test "Open time is converted and copied" do
      opened_time = Time.parse(opened.time)

      assert(account.opened_time == opened_time)
    end
  end
end
