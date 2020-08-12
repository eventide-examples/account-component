require_relative '../../automated_init'

context "Handle Commands" do
  context "Open" do
    context "Opened" do
      handler = Handlers::Commands.new
      open = Controls::Commands::Open.example

      account = Controls::Account::New.example

      clock_time = Controls::Time::Processed::Raw.example

      fixture(
        Messaging::Fixtures::Handler,
        handler,
        open,
        account,
        clock_time: clock_time
      ) do |handler|
        opened = handler.assert_write(Messages::Events::Opened) do |write|
          write.assert_stream_name("account-#{open.account_id}")
          write.assert_expected_version(:no_stream)
        end

        handler.assert_written_message(opened) do |opened|
          opened.assert_attributes_copied([
            :account_id,
            :customer_id,
            :time
          ])

          opened.assert_attribute_value(:processed_time, Clock.iso8601(clock_time))

          opened.assert_attributes_assigned
        end
      end
    end
  end
end
