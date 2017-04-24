require_relative '../../../test_init'

context "Handle Commands" do
  context "Withdraw" do
    context "Reserved" do
      withdraw_id = Identifier::UUID::Random.get

      withdraw = Controls::Commands::Withdraw.example(id: withdraw_id)

      Handlers::Commands.(withdraw)

      transaction_stream_name = "accountTransaction-#{withdraw_id}"

      event_data, * = MessageStore::Postgres::Get.(transaction_stream_name, position: 0, batch_size: 1)

      written_message = Messaging::Message::Import.(event_data, withdraw.class)

      test "Withdraw command is written to transaction stream" do
        refute(written_message.nil?)
      end

      context "Attributes" do
        test "withdrawal_id" do
          assert(written_message.withdrawal_id == withdraw.withdrawal_id)
        end

        test "account_id" do
          assert(written_message.account_id == withdraw.account_id)
        end

        test "amount" do
          assert(written_message.amount == withdraw.amount)
        end

        test "time" do
          assert(written_message.time == withdraw.time)
        end
      end
    end
  end
end
