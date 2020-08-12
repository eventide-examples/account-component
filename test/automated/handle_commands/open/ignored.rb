require_relative '../../automated_init'

context "Handle Commands" do
  context "Open" do
    context "Ignored" do
      handler = Handlers::Commands.new
      open = Controls::Commands::Open.example

      account = Controls::Account::Open.example

      fixture(
        Messaging::Fixtures::Handler,
        handler,
        open,
        account
      ) do |handler|
        handler.refute_write
      end
    end
  end
end
