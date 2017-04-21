module AccountComponent
  module Messages
    module Events
      class Closed
        include Messaging::Message

        attribute :account_id, String
        attribute :time, String
        attribute :processed_time, String
      end
    end
  end
end
