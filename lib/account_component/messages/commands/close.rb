module AccountComponent
  module Messages
    module Commands
      class Close
        include Messaging::Message

        attribute :account_id, String
        attribute :time, String
      end
    end
  end
end
