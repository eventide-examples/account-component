module AccountComponent
  module Messages
    module Commands
      class Deposit
        include Messaging::Message

        attribute :deposit_id, String
        attribute :account_id, String
        attribute :amount, Numeric
        attribute :time, String
      end
    end
  end
end
