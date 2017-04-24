module AccountComponent
  module Controls
    module Write
      module Withdraw
        def self.call(id: nil, account_id: nil, amount: nil)
          id ||= ID.example
          account_id ||= Account.id
          amount ||= Money.example

          deposit = Commands::Withdraw.example(
            id: id,
            account_id: account_id,
            amount: amount
          )

          stream_name = Messaging::StreamName.command_stream_name(id, 'account')

          Messaging::Postgres::Write.(deposit, stream_name)
        end
      end
    end
  end
end
