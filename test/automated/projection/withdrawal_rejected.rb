require_relative '../automated_init'

context "Projection" do
  context "Withdrawal Rejected" do
    account = Controls::Account::Balance.example

    withdrawal_rejected = Controls::Events::WithdrawalRejected.example

    sequence = withdrawal_rejected.sequence or fail

    Projection.(account, withdrawal_rejected)

    test "Sequence is set" do
      assert(account.sequence == sequence)
    end
  end
end
