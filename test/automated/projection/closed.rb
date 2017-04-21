require_relative '../automated_init'

context "Projection" do
  context "Closed" do
    account = Controls::Account.example

    assert(account.closed_time.nil?)

    closed = Controls::Events::Closed.example

    Projection.(account, closed)

    test "Closed time is converted and copied" do
      closed_time = Time.parse(closed.time)

      assert(account.closed_time == closed_time)
    end
  end
end
