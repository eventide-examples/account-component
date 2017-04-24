module AccountComponent
  module Controls
    module Commands
      module Withdraw
        def self.example(id: nil, account_id: nil, amount: nil)
          id ||= ID.example
          account_id ||= Account.id
          amount ||= Money.example

          withdraw = AccountComponent::Messages::Commands::Withdraw.build

          withdraw.withdrawal_id = id
          withdraw.account_id = account_id
          withdraw.amount = amount
          withdraw.time = Controls::Time::Effective.example

          withdraw.metadata.global_position = Position.example

          withdraw
        end
      end
    end
  end
end
