require_relative '../../automated_init'

context "Commands" do
  context "Withdraw" do
    context "Previous Message" do
      previous_message = Controls::Message.example

      withdrawal_id = Controls::ID.example
      account_id = Controls::Account.id
      amount = Controls::Money.example

      withdraw = Commands::Withdraw.new
      withdraw.clock.now = Controls::Time::Raw.example

      withdraw.(withdrawal_id: withdrawal_id, account_id: account_id, amount: amount, previous_message: previous_message)

      write = withdraw.write

      withdraw_message = write.one_message do |written|
        written.instance_of?(Messages::Commands::Withdraw)
      end

      refute(withdraw_message.nil?)

      test "Withdraw message follows previous message" do
        assert(withdraw_message.follows?(previous_message))
      end
    end
  end
end
