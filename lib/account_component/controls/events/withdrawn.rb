module AccountComponent
  module Controls
    module Events
      module Withdrawn
        def self.example
          withdrawn = AccountComponent::Messages::Events::Withdrawn.build

          withdrawn.withdrawal_id = ID.example
          withdrawn.account_id = Account.id
          withdrawn.amount = Money.example
          withdrawn.time = Controls::Time::Effective.example
          withdrawn.processed_time = Controls::Time::Processed.example

          withdrawn.sequence = Sequence.example

          withdrawn
        end
      end
    end
  end
end
