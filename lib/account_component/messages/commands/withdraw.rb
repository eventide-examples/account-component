module AccountComponent
  module Messages
    module Commands
      class Withdraw
        include Messaging::Message

        # TODO Add withdrawal ID attribute
        attribute :account_id, String
        attribute :amount, Numeric
        attribute :time, String
      end
    end
  end
end
