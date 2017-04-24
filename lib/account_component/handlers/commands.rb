module AccountComponent
  module Handlers
    class Commands
      include Log::Dependency
      include Messaging::Handle
      include Messaging::StreamName
      include Messages::Commands
      include Messages::Events

      dependency :write, Messaging::Postgres::Write
      dependency :clock, Clock::UTC
      dependency :store, Store

      def configure
        Messaging::Postgres::Write.configure(self)
        Clock::UTC.configure(self)
        Store.configure(self)
      end

      category :account

      handle Open do |open|
        account_id = open.account_id

        account, version = store.fetch(account_id, include: :version)

        if account.open?
          logger.info(tag: :ignored) { "Command ignored (Command: #{open.message_type}, Account ID: #{account_id}, Customer ID: #{open.customer_id})" }
          return
        end

        time = clock.iso8601

        opened = Opened.follow(open)
        opened.processed_time = time

        stream_name = stream_name(account_id)

        write.(opened, stream_name, expected_version: version)
      end

      handle Close do |close|
        account_id = close.account_id

        account, version = store.fetch(account_id, include: :version)

        if account.closed?
          logger.info(tag: :ignored) { "Command ignored (Command: #{close.message_type}, Account ID: #{account_id})" }
          return
        end

        time = clock.iso8601

        closed = Closed.follow(close)
        closed.processed_time = time

        stream_name = stream_name(account_id)

        write.(closed, stream_name, expected_version: version)
      end

      handle Deposit do |deposit|
        transaction_stream_name = stream_name(deposit.deposit_id, 'accountTransaction')

        deposit = Deposit.follow(deposit)

        Try.(MessageStore::ExpectedVersion::Error) do
          write.initial(deposit, transaction_stream_name)
        end
      end

      handle Withdraw do |withdraw|
        transaction_stream_name = stream_name(withdraw.withdrawal_id, 'accountTransaction')

        withdraw = Withdraw.follow(withdraw)

        Try.(MessageStore::ExpectedVersion::Error) do
          write.initial(withdraw, transaction_stream_name)
        end
      end
    end
  end
end
