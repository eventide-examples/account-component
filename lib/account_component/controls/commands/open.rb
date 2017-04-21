module AccountComponent
  module Controls
    module Commands
      module Open
        def self.example
          open = AccountComponent::Messages::Commands::Open.build

          open.account_id = Account.id
          open.customer_id = Customer.id
          open.time = Controls::Time::Effective.example

          open
        end
      end
    end
  end
end
