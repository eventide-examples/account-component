module AccountComponent
  module Messages
    module Events
      class WithdrawalRejected
        include Messaging::Message

        attribute :withdrawal_id, String
        attribute :account_id, String
        attribute :amount, Numeric
        attribute :time, String
        attribute :sequence, Integer
      end
    end
  end
end
