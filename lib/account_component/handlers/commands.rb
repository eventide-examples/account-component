module AccountComponent
  module Handlers
    class Commands
      include Messaging::Handle
      include Messaging::StreamName
      include Messages::Commands
      include Messages::Events

      dependency :write, Messaging::Postgres::Write
      dependency :clock, Clock::UTC

      def configure
        Messaging::Postgres::Write.configure(self)
        Clock::UTC.configure(self)
      end

      category :account

      handle Deposit do |deposit|
        account_id = deposit.account_id

        time = clock.iso8601

        deposited = Deposited.follow(deposit)
        deposited.processed_time = time

        stream_name = stream_name(account_id)

        write.(deposited, stream_name)
      end
    end
  end
end
