require_relative '../automated_init'

context "Account" do
  context "Sufficient Funds" do
    account = Controls::Account::Balance.example

    context "Sufficient" do
      context "Balance equals amount" do
        amount = account.balance

        sufficient_funds = account.sufficient_funds?(amount)

        test do
          assert(sufficient_funds)
        end
      end

      context "Balance is greater than amount" do
        amount = account.balance - 1

        sufficient_funds = account.sufficient_funds?(amount)

        test do
          assert(sufficient_funds)
        end
      end
    end

    context "Insufficient" do
      context "Balance is less than amount" do
        amount = account.balance + 1

        sufficient_funds = account.sufficient_funds?(amount)

        test do
          refute(sufficient_funds)
        end
      end
    end
  end
end
