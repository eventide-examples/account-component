module AccountComponent
  module Controls
    module Events
      module Opened
        def self.example
          opened = AccountComponent::Messages::Events::Opened.build

          opened.account_id = Account.id
          opened.customer_id = Customer.id
          opened.time = Controls::Time::Effective.example
          opened.processed_time = Controls::Time::Processed.example

          opened
        end
      end
    end
  end
end
