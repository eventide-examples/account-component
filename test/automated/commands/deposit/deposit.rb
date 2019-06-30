require_relative '../../automated_init'

context "Commands" do
  context "Deposit" do
    deposit_id = Controls::ID.example
    account_id = Controls::Account.id
    amount = Controls::Money.example
    effective_time = Controls::Time::Effective::Raw.example

    deposit = Commands::Deposit.new
    deposit.clock.now = effective_time

    deposit.(deposit_id: deposit_id, account_id: account_id, amount: amount)

    write = deposit.write

    deposit_message = write.one_message do |written|
      written.instance_of?(Messages::Commands::Deposit)
    end

    test "Deposit command is written" do
      refute(deposit_message.nil?)
    end

    test "Written to the account command stream" do
      written_to_stream = write.written?(deposit_message) do |stream_name|
        stream_name == "account:command-#{account_id}"
      end

      assert(written_to_stream)
    end

    context "Attributes" do
      test "deposit_id is assigned" do
        assert(deposit_message.deposit_id == deposit_id)
      end

      test "account_id" do
        assert(deposit_message.account_id == account_id)
      end

      test "amount" do
        assert(deposit_message.amount == amount)
      end

      test "time" do
        effective_time_iso8601 = Clock.iso8601(effective_time)

        assert(deposit_message.time == effective_time_iso8601)
      end
    end
  end
end
