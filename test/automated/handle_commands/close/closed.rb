require_relative '../../automated_init'

context "Handle Commands" do
  context "Close" do
    context "Closed" do
      handler = Handlers::Commands.new
      close = Controls::Commands::Close.example

      account = Controls::Account::Open.example
      account_version = Controls::Version.example

      clock_time = Controls::Time::Processed::Raw.example

      fixture(
        Messaging::Fixtures::Handler,
        handler,
        close,
        account,
        account_version,
        clock_time: clock_time
      ) do |handler|
        closed = handler.assert_write(Messages::Events::Closed) do |write|
          write.assert_stream_name("account-#{account.id}")
          write.assert_expected_version(account_version)
        end

        handler.assert_written_message(closed) do |closed|
          closed.assert_attributes_copied([
            :account_id,
            :time
          ])

          closed.assert_attribute_value(:processed_time, Clock.iso8601(clock_time))
        end
      end
    end
  end
end
