require_relative '../../automated_init'

context "Handle Commands" do
  context "Withdraw" do
    context "Withdrawn" do
      handler = Handlers::Commands.new

      processed_time = Controls::Time::Processed::Raw.example

      handler.clock.now = processed_time

      account = Controls::Account::Balance.example

      handler.store.add(account.id, account)

      withdraw = Controls::Commands::Withdraw.example

      account_id = withdraw.account_id or fail
      amount = withdraw.amount or fail
      effective_time = withdraw.time or fail

      handler.(withdraw)

      writer = handler.write

      withdrawn = writer.one_message do |event|
        event.instance_of?(Messages::Events::Withdrawn)
      end

      test "Withdrawn Event is Written" do
        refute(withdrawn.nil?)
      end

      test "Written to the account stream" do
        written_to_stream = writer.written?(withdrawn) do |stream_name|
          stream_name == "account-#{account_id}"
        end

        assert(written_to_stream)
      end

      context "Attributes" do
        test "account_id" do
          assert(withdrawn.account_id == account_id)
        end

        test "amount" do
          assert(withdrawn.amount == amount)
        end

        test "time" do
          assert(withdrawn.time == effective_time)
        end

        test "processed_time" do
          processed_time_iso8601 = Clock::UTC.iso8601(processed_time)

          assert(withdrawn.processed_time == processed_time_iso8601)
        end
      end
    end
  end
end
