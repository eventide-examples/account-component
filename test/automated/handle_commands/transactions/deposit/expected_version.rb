require_relative '../../../automated_init'

context "Handle Commands" do
  context "Transactions" do
    context "Deposit" do
      context "Expected Version" do
        handler = Handlers::Commands::Transactions.new

        deposit = Controls::Commands::Deposit.example

        account = Controls::Account.example

        version = Controls::Version.example

        handler.store.add(account.id, account, version)

        handler.(deposit)

        writer = handler.write

        deposited = writer.one_message do |event|
          event.instance_of?(Messages::Events::Deposited)
        end

        test "Is entity version" do
          written_to_stream = writer.written?(deposited) do |_, expected_version|
            expected_version == version
          end

          assert(written_to_stream)
        end
      end
    end
  end
end
