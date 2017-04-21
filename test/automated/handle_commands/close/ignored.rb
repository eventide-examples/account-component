require_relative '../../automated_init'

context "Handle Commands" do
  context "Close" do
    context "Ignored" do
      handler = Handlers::Commands.new

      close = Controls::Commands::Close.example

      account = Controls::Account::Closed.example

      handler.store.add(account.id, account)

      handler.(close)

      writer = handler.write

      closed = writer.one_message do |event|
        event.instance_of?(Messages::Events::Closed)
      end

      test "Closed Event is not Written" do
        assert(closed.nil?)
      end
    end
  end
end
