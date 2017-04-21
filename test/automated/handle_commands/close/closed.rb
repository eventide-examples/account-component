require_relative '../../automated_init'

context "Handle Commands" do
  context "Close" do
    context "Closed" do
      handler = Handlers::Commands.new

      processed_time = Controls::Time::Processed::Raw.example

      handler.clock.now = processed_time

      close = Controls::Commands::Close.example

      account_id = close.account_id or fail
      effective_time = close.time or fail

      handler.(close)

      writer = handler.write

      closed = writer.one_message do |event|
        event.instance_of?(Messages::Events::Closed)
      end

      test "Closed Event is Written" do
        refute(closed.nil?)
      end

      test "Written to the account stream" do
        written_to_stream = writer.written?(closed) do |stream_name|
          stream_name == "account-#{account_id}"
        end

        assert(written_to_stream)
      end

      context "Attributes" do
        test "account_id" do
          assert(closed.account_id == account_id)
        end

        test "time" do
          assert(closed.time == effective_time)
        end

        test "processed_time" do
          processed_time_iso8601 = Clock::UTC.iso8601(processed_time)

          assert(closed.processed_time == processed_time_iso8601)
        end
      end
    end
  end
end
