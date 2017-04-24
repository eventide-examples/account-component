require_relative '../../../test_init'

context "Handle Commands" do
  context "Withdraw" do
    context "Not Reserved" do
      withdraw_id = Identifier::UUID::Random.get

      withdraw = Controls::Commands::Withdraw.example(id: withdraw_id)

      transaction_stream_name = "accountTransaction-#{withdraw_id}"

      Messaging::Postgres::Write.(withdraw, transaction_stream_name)

      Handlers::Commands.(withdraw)

      event_data, * = MessageStore::Postgres::Get.(transaction_stream_name, position: 1, batch_size: 1)

      test "Withdraw command is not written to transaction stream" do
        assert(event_data.nil?)
      end
    end
  end
end
