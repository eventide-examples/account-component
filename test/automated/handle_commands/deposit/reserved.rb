require_relative '../../../test_init'

context "Handle Commands" do
  context "Deposit" do
    context "Reserved" do
      deposit_id = Identifier::UUID::Random.get

      deposit = Controls::Commands::Deposit.example(id: deposit_id)

      Handlers::Commands.(deposit)

      transaction_stream_name = "accountTransaction-#{deposit_id}"

      event_data, * = MessageStore::Postgres::Get.(transaction_stream_name, position: 0, batch_size: 1)

      written_message = Messaging::Message::Import.(event_data, deposit.class)

      test "Deposit command is written to transaction stream" do
        refute(written_message.nil?)
      end

      context "Attributes" do
        test "deposit_id" do
          assert(written_message.deposit_id == deposit.deposit_id)
        end

        test "account_id" do
          assert(written_message.account_id == deposit.account_id)
        end

        test "amount" do
          assert(written_message.amount == deposit.amount)
        end

        test "time" do
          assert(written_message.time == deposit.time)
        end
      end
    end
  end
end
