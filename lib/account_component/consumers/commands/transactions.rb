module AccountComponent
  module Consumers
    class Commands
      class Transactions
        include Consumer::Postgres

        handler Handlers::Commands::Transactions
      end
    end
  end
end
