module AccountComponent
  module Commands
    module Command
      def self.included(cls)
        cls.class_exec do
          include Dependency
          include Virtual

          include Messaging::StreamName
          include Messages::Events

          extend Build
          extend BuildMessage

          category :account

          abstract :message_class

          dependency :write, Messaging::Postgres::Write
          dependency :clock, Clock::UTC
        end
      end

      def configure
        Messaging::Postgres::Write.configure(self)
        Clock::UTC.configure(self)
      end

      module Build
        def build
          instance = new
          instance.configure
          instance
        end
      end

      module BuildMessage
        def build_message(message_class, previous_message)
          message = message_class.new

          unless previous_message.nil?
            message.metadata.follow(previous_message.metadata)
          end

          message
        end
      end
    end
  end
end
