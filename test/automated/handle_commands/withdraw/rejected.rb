require_relative '../../automated_init'

context "Handle Commands" do
  context "Withdraw" do
    context "Rejected" do
      handler = Handlers::Commands.new

      account_id = Identifier::UUID::Random.get

      amount = 12

      processed_time = Time.now

      handler.clock.now = processed_time

      account = Account.new
      account.id = account_id
      account.balance = 11

      handler.store.add(account_id, account)

      withdraw = Messages::Commands::Withdraw.new
      withdraw.account_id = account_id
      withdraw.amount = amount
      withdraw.time = '2000-01-01T11:11:11.000Z'

      handler.(withdraw)

      writer = handler.write

      withdrawal_rejected = writer.one_message do |event|
        event.instance_of?(Messages::Events::WithdrawalRejected)
      end

      test "Withdrawal Rejected Event is Written" do
        refute(withdrawal_rejected.nil?)
      end

      test "Written to the account stream" do
        written_to_stream = writer.written?(withdrawal_rejected) do |stream_name|
          stream_name == "account-#{account_id}"
        end

        assert(written_to_stream)
      end

      context "Attributes" do
        test "account_id" do
          assert(withdrawal_rejected.account_id == account_id)
        end

        test "amount" do
          assert(withdrawal_rejected.amount == amount)
        end

        test "time" do
          processed_time_iso8601 = Clock::UTC.iso8601(processed_time)

          assert(withdrawal_rejected.time == processed_time_iso8601)
        end
      end
    end
  end
end
