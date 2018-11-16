require_relative '../../automated_init'

context "Commands" do
  context "Withdraw" do
    context "Optional Withdrawal ID" do
      amount = Controls::Money.example
      account_id = Identifier::UUID::Random.get

      context "Omitted" do
        withdraw = Commands::Withdraw.(account_id: account_id, amount: amount)

        test "An ID is assigned" do
          refute(withdraw.withdrawal_id.nil?)
        end
      end

      context "Supplied" do
        withdrawal_id = Controls::ID.example

        withdraw = Commands::Withdraw.(
          account_id: account_id,
          amount: amount,
          withdrawal_id: withdrawal_id
        )

        test "ID is assigned to supplied ID" do
          assert(withdraw.withdrawal_id == withdrawal_id)
        end
      end
    end
  end
end
