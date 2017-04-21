require_relative '../../automated_init'

context "Handle Commands" do
  context "Deposit" do
    context "Deposited" do
      handler = Handlers::Commands.new

      processed_time = Time.now

      handler.clock.now = processed_time

      account_id = Identifier::UUID::Random.get

      deposit = Messages::Commands::Deposit.new
      deposit.account_id = account_id
      deposit.amount = 11
      deposit.time = '2000-01-01T11:11:11.000Z'

      handler.(deposit)

      writer = handler.write

      deposited = writer.one_message do |event|
        event.instance_of?(Messages::Events::Deposited)
      end

      test "Deposited Event is Written" do
        refute(deposited.nil?)
      end

      test "Written to the account stream" do
        written_to_stream = writer.written?(deposited) do |stream_name|
          stream_name == "account-#{account_id}"
        end

        assert(written_to_stream)
      end

      context "Attributes" do
        test "account_id" do
          assert(deposited.account_id == account_id)
        end

        test "amount" do
          assert(deposited.amount == 11)
        end

        test "time" do
          assert(deposited.time == '2000-01-01T11:11:11.000Z')
        end

        test "processed_time" do
          processed_time_iso8601 = Clock::UTC.iso8601(processed_time)

          assert(deposited.processed_time == processed_time_iso8601)
        end
      end
    end
  end
end
