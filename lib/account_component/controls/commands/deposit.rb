module AccountComponent
  module Controls
    module Commands
      module Deposit
        def self.example
          deposit = AccountComponent::Messages::Commands::Deposit.build

          deposit.account_id = Account.id
          deposit.amount = Money.example
          deposit.time = Controls::Time::Effective.example

          deposit
        end
      end
    end
  end
end
