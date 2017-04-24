require_relative '../../../automated_init'

context "Handle Commands" do
  context "Transactions" do
    context "Deposit" do
      context "Deposited" do
        handler = Handlers::Commands::Transactions.new

        processed_time = Controls::Time::Processed::Raw.example

        handler.clock.now = processed_time

        deposit = Controls::Commands::Deposit.example

        account_id = deposit.account_id or fail
        amount = deposit.amount or fail
        effective_time = deposit.time or fail
        global_position = deposit.metadata.global_position or fail

        handler.(deposit)

        writer = handler.write

        deposited = writer.one_message do |event|
          event.instance_of?(Messages::Events::Deposited)
        end

        test "Deposited Event is Written" do
          refute(deposited.nil?)
        end

        test "Written to the account stream" do
          written_to_stream = writer.written?(deposited) do |stream_name|
            stream_name == "account-#{account_id}"
          end

          assert(written_to_stream)
        end

        context "Attributes" do
          test "account_id" do
            assert(deposited.account_id == account_id)
          end

          test "amount" do
            assert(deposited.amount == amount)
          end

          test "time" do
            assert(deposited.time == effective_time)
          end

          test "processed_time" do
            processed_time_iso8601 = Clock::UTC.iso8601(processed_time)

            assert(deposited.processed_time == processed_time_iso8601)
          end

          test "sequence" do
            assert(deposited.sequence == global_position)
          end
        end
      end
    end
  end
end
