require_relative '../../automated_init'

context "Handle Commands" do
  context "Open" do
    context "Opened" do
      handler = Handlers::Commands.new

      processed_time = Controls::Time::Processed::Raw.example

      handler.clock.now = processed_time

      open = Controls::Commands::Open.example

      account_id = open.account_id or fail
      customer_id = open.customer_id or fail
      effective_time = open.time or fail

      handler.(open)

      writer = handler.write

      opened = writer.one_message do |event|
        event.instance_of?(Messages::Events::Opened)
      end

      test "Opened Event is Written" do
        refute(opened.nil?)
      end

      test "Written to the account stream" do
        written_to_stream = writer.written?(opened) do |stream_name|
          stream_name == "account-#{account_id}"
        end

        assert(written_to_stream)
      end

      context "Attributes" do
        test "account_id" do
          assert(opened.account_id == account_id)
        end

        test "customer_id" do
          assert(opened.customer_id == customer_id)
        end

        test "time" do
          assert(opened.time == effective_time)
        end

        test "processed_time" do
          processed_time_iso8601 = Clock::UTC.iso8601(processed_time)

          assert(opened.processed_time == processed_time_iso8601)
        end
      end
    end
  end
end
