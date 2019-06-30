module AccountComponent
  module Commands
    class Deposit
      include Command

      def self.configure(receiver, attr_name: nil)
        attr_name ||= :deposit
        instance = build
        receiver.public_send("#{attr_name}=", instance)
      end

      def self.call(account_id:, amount:, deposit_id: nil, previous_message: nil)
        deposit_id ||= Identifier::UUID::Random.get
        instance = self.build
        instance.(deposit_id: deposit_id, account_id: account_id, amount: amount, previous_message: previous_message)
      end

      def call(deposit_id:, account_id:, amount:, previous_message: nil)
        deposit = self.class.build_message(Messages::Commands::Deposit, previous_message)

        deposit.deposit_id = deposit_id
        deposit.account_id = account_id
        deposit.amount = amount
        deposit.time = clock.iso8601

        stream_name = command_stream_name(account_id)

        write.(deposit, stream_name)

        deposit
      end
    end
  end
end
