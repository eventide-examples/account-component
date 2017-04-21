module AccountComponent
  module Messages
    module Commands
      class Open
        include Messaging::Message

        attribute :account_id, String
        attribute :customer_id, String
        attribute :time, String
      end
    end
  end
end
