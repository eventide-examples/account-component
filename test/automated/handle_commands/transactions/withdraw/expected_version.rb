require_relative '../../../automated_init'

context "Handle Commands" do
  context "Transactions" do
    context "Withdraw" do
      context "Expected Version" do
        handler = Handlers::Commands::Transactions.new

        withdraw = Controls::Commands::Withdraw.example

        account = Controls::Account.example

        version = Controls::Version.example

        handler.store.add(account.id, account, version)

        handler.(withdraw)

        writer = handler.write

        withdrawn = writer.one_message do |event|
          event.instance_of?(Messages::Events::Withdrawn)
        end

        test "Is entity version" do
          written_to_stream = writer.written?(withdrawn) do |_, expected_version|
            expected_version == version
          end

          assert(written_to_stream)
        end
      end
    end
  end
end
