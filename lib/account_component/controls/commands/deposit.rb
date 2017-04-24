module AccountComponent
  module Controls
    module Commands
      module Deposit
        def self.example(id: nil)
          id ||= ID.example

          deposit = AccountComponent::Messages::Commands::Deposit.build

          deposit.deposit_id = id
          deposit.account_id = Account.id
          deposit.amount = Money.example
          deposit.time = Controls::Time::Effective.example

          deposit.metadata.global_position = Position.example

          deposit
        end
      end
    end
  end
end
