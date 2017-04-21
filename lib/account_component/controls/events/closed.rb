module AccountComponent
  module Controls
    module Events
      module Closed
        def self.example
          closed = AccountComponent::Messages::Events::Closed.build

          closed.account_id = Account.id
          closed.time = Controls::Time::Effective.example
          closed.processed_time = Controls::Time::Processed.example

          closed
        end
      end
    end
  end
end
