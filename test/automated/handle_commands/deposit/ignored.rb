require_relative '../../automated_init'

context "Handle Commands" do
  context "Deposit" do
    context "Ignored" do
      handler = Handlers::Commands.new

      deposit = Controls::Commands::Deposit.example

      account = Controls::Account::Sequence.example

      assert(account.processed?(deposit.metadata.global_position))

      handler.store.add(account.id, account)

      handler.(deposit)

      writer = handler.write

      deposited = writer.one_message do |event|
        event.instance_of?(Messages::Events::Deposited)
      end

      test "Deposited Event is not Written" do
        assert(deposited.nil?)
      end
    end
  end
end
