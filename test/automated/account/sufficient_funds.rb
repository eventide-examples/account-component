require_relative '../automated_init'

context "Account" do
  context "Sufficient Funds" do
    account = Account.new
    account.balance = 11

    context "Sufficient" do
      context "Balance equals amount" do
        amount = 11

        sufficient_funds = account.sufficient_funds?(amount)

        test do
          assert(sufficient_funds)
        end
      end

      context "Balance is greater than amount" do
        amount = 10

        sufficient_funds = account.sufficient_funds?(amount)

        test do
          assert(sufficient_funds)
        end
      end
    end

    context "Insufficient" do
      context "Balance is less than amount" do
        amount = 12

        sufficient_funds = account.sufficient_funds?(amount)

        test do
          refute(sufficient_funds)
        end
      end
    end
  end
end
