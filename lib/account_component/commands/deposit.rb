module AccountComponent
  module Commands
    class Deposit
      include Command

      def self.configure(receiver, attr_name: nil)
        # TODO: Configure the receiver with an operational instance, using an attribute name of `deposit' by default
      end

      def self.call(account_id:, amount:, deposit_id: nil, previous_message: nil)
        # TODO: Assign a random UUID to deposit_id if not provided

        # TODO: Construct and actuate an operational instance
      end

      def call(deposit_id:, account_id:, amount:, previous_message: nil)
        # TODO: Build a deposit message and set its attributes to the given values

        # TODO: Write the deposit message to account command stream
      end
    end
  end
end
