require_relative '../../automated_init'

context "Handle Commands" do
  context "Open" do
    context "Expected Version" do
      handler = Handlers::Commands.new

      open = Controls::Commands::Open.example

      account = Controls::Account::New.example

      version = Controls::Version.example

      handler.store.add(open.account_id, account, version)

      handler.(open)

      writer = handler.write

      opened = writer.one_message do |event|
        event.instance_of?(Messages::Events::Opened)
      end

      test "Is entity version" do
        written_to_stream = writer.written?(opened) do |_, expected_version|
          expected_version == version
        end

        assert(written_to_stream)
      end
    end
  end
end
