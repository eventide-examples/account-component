require_relative '../../automated_init'

context "Commands" do
  context "Deposit" do
    context "Previous Message" do
      previous_message = Controls::Message.example

      deposit_id = Controls::ID.example
      account_id = Controls::Account.id
      amount = Controls::Money.example

      deposit = Commands::Deposit.new
      deposit.clock.now = Controls::Time::Raw.example

      deposit.(deposit_id: deposit_id, account_id: account_id, amount: amount, previous_message: previous_message)

      write = deposit.write

      deposit_message = write.one_message do |written|
        written.instance_of?(Messages::Commands::Deposit)
      end

      refute(deposit_message.nil?)

      test "Deposit message follows previous message" do
        assert(deposit_message.follows?(previous_message))
      end
    end
  end
end
