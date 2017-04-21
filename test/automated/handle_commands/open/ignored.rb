require_relative '../../automated_init'

context "Handle Commands" do
  context "Open" do
    context "Ignored" do
      handler = Handlers::Commands.new

      open = Controls::Commands::Open.example

      account = Controls::Account::Open.example

      handler.store.add(account.id, account)

      handler.(open)

      writer = handler.write

      opened = writer.one_message do |event|
        event.instance_of?(Messages::Events::Opened)
      end

      test "Opened Event is not Written" do
        assert(opened.nil?)
      end
    end
  end
end
