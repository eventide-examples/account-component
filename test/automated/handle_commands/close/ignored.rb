require_relative '../../automated_init'

context "Handle Commands" do
  context "Close" do
    context "Ignored" do
      handler = Handlers::Commands.new
      close = Controls::Commands::Close.example

      account = Controls::Account::Closed.example

      fixture(
        Messaging::Fixtures::Handler,
        handler,
        close,
        account
      ) do |handler|
        handler.refute_write
      end
    end
  end
end
