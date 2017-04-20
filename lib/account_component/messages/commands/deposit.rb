module AccountComponent
  module Messages
    module Commands
      class Deposit
        include Messaging::Message

        attribute :account_id, String
        attribute :amount, Numeric
        attribute :time, String
      end
    end
  end
end
