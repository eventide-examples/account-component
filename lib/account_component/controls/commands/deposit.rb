module AccountComponent
  module Controls
    module Commands
      module Deposit
        def self.example(id: nil, account_id: nil, amount: nil)
          id ||= ID.example
          account_id ||= Account.id
          amount ||= Money.example

          deposit = AccountComponent::Messages::Commands::Deposit.build

          deposit.deposit_id = id
          deposit.account_id = account_id
          deposit.amount = amount
          deposit.time = Controls::Time::Effective.example

          deposit.metadata.global_position = Position.example

          deposit
        end
      end
    end
  end
end
