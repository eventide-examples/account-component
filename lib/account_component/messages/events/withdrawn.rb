module AccountComponent
  module Messages
    module Events
      class Withdrawn
        include Messaging::Message

        # TODO Add withdrawal ID attribute
        attribute :account_id, String
        attribute :amount, Numeric
        attribute :time, String
        attribute :processed_time, String
        attribute :sequence, Integer
      end
    end
  end
end
