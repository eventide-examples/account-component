require_relative '../../automated_init'

context "Commands" do
  context "Deposit" do
    context "Optional Deposit ID" do
      amount = Controls::Money.example
      account_id = Identifier::UUID::Random.get

      context "Omitted" do
        deposit = Commands::Deposit.(account_id: account_id, amount: amount)

        test "An ID is assigned" do
          refute(deposit.deposit_id.nil?)
        end
      end

      context "Supplied" do
        deposit_id = Controls::ID.example

        deposit = Commands::Deposit.(
          account_id: account_id,
          amount: amount,
          deposit_id: deposit_id
        )

        test "ID is assigned to supplied ID" do
          assert(deposit.deposit_id == deposit_id)
        end
      end
    end
  end
end
