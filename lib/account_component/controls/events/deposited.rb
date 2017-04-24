module AccountComponent
  module Controls
    module Events
      module Deposited
        def self.example
          deposited = AccountComponent::Messages::Events::Deposited.build

          deposited.deposit_id = ID.example
          deposited.account_id = Account.id
          deposited.amount = Money.example
          deposited.time = Controls::Time::Effective.example
          deposited.processed_time = Controls::Time::Processed.example

          deposited.sequence = Sequence.example

          deposited
        end
      end
    end
  end
end
