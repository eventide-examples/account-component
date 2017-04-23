require_relative '../../automated_init'

context "Handle Commands" do
  context "Close" do
    context "Expected Version" do
      handler = Handlers::Commands.new

      close = Controls::Commands::Close.example

      account = Controls::Account.example

      version = Controls::Version.example

      handler.store.add(account.id, account, version)

      handler.(close)

      writer = handler.write

      closed = writer.one_message do |event|
        event.instance_of?(Messages::Events::Closed)
      end

      test "Is entity version" do
        written_to_stream = writer.written?(closed) do |_, expected_version|
          expected_version == version
        end

        assert(written_to_stream)
      end
    end
  end
end
