module AccountComponent
  module Controls
    module Commands
      module Close
        def self.example
          close = AccountComponent::Messages::Commands::Close.build

          close.account_id = Account.id
          close.time = Controls::Time::Effective.example

          close
        end
      end
    end
  end
end
