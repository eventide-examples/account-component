module AccountComponent
  module Controls
    module Commands
      module Withdraw
        def self.example(id: nil)
          id ||= ID.example

          withdraw = AccountComponent::Messages::Commands::Withdraw.build

          withdraw.withdrawal_id = id
          withdraw.account_id = Account.id
          withdraw.amount = Money.example
          withdraw.time = Controls::Time::Effective.example

          withdraw.metadata.global_position = Position.example

          withdraw
        end
      end
    end
  end
end
