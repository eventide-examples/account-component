require_relative '../../../test_init'

context "Handle Commands" do
  context "Deposit" do
    context "Not Reserved" do
      deposit_id = Identifier::UUID::Random.get

      deposit = Controls::Commands::Deposit.example(id: deposit_id)

      transaction_stream_name = "accountTransaction-#{deposit_id}"

      Messaging::Postgres::Write.(deposit, transaction_stream_name)

      Handlers::Commands.(deposit)

      event_data, * = MessageStore::Postgres::Get.(transaction_stream_name, position: 1, batch_size: 1)

      test "Deposit command is not written to transaction stream" do
        assert(event_data.nil?)
      end
    end
  end
end
