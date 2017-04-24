module AccountComponent
  module Start
    def self.call
      Consumers::Commands.start('account:command')
      Consumers::Commands::Transactions.start('accountTransaction')
    end
  end
end
