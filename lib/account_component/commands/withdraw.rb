module AccountComponent
  module Commands
    class Withdraw
      include Command

      def self.configure(receiver, attr_name: nil)
        attr_name ||= :withdraw
        instance = build
        receiver.public_send("#{attr_name}=", instance)
      end

      def self.call(account_id:, amount:, withdrawal_id: nil, previous_message: nil)
        withdrawal_id ||= Identifier::UUID::Random.get
        instance = self.build
        instance.(withdrawal_id: withdrawal_id, account_id: account_id, amount: amount, previous_message: previous_message)
      end

      def call(withdrawal_id:, account_id:, amount:, previous_message: nil)
        withdraw = self.class.build_message(Messages::Commands::Withdraw, previous_message)

        withdraw.withdrawal_id = withdrawal_id
        withdraw.account_id = account_id
        withdraw.amount = amount
        withdraw.time = clock.iso8601

        stream_name = command_stream_name(account_id)

        write.(withdraw, stream_name)

        withdraw
      end
    end
  end
end
