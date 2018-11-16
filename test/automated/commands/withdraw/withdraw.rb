require_relative '../../automated_init'

context "Commands" do
  context "Withdraw" do
    withdrawal_id = Controls::ID.example
    account_id = Controls::Account.id
    amount = Controls::Money.example
    effective_time = Controls::Time::Effective::Raw.example

    withdraw = Commands::Withdraw.new
    withdraw.clock.now = effective_time

    withdraw.(withdrawal_id: withdrawal_id, account_id: account_id, amount: amount)

    write = withdraw.write

    withdraw_message = write.one_message do |written|
      written.instance_of?(Messages::Commands::Withdraw)
    end

    test "Withdraw command is written" do
      refute(withdraw_message.nil?)
    end

    test "Written to the account command stream" do
      written_to_stream = write.written?(withdraw_message) do |stream_name|
        stream_name == "account:command-#{account_id}"
      end

      assert(written_to_stream)
    end

    context "Attributes" do
      test "withdrawal_id is assigned" do
        assert(withdraw_message.withdrawal_id == withdrawal_id)
      end

      test "account_id" do
        assert(withdraw_message.account_id == account_id)
      end

      test "amount" do
        assert(withdraw_message.amount == amount)
      end

      test "time" do
        effective_time_iso8601 = Clock.iso8601(effective_time)

        assert(withdraw_message.time == effective_time_iso8601)
      end
    end
  end
end
