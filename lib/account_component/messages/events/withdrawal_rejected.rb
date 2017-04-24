module AccountComponent
  module Messages
    module Events
      class WithdrawalRejected
        include Messaging::Message

        attribute :account_id, String
        attribute :amount, Numeric
        attribute :time, String
        # TODO Add sequence attribute
      end
    end
  end
end
