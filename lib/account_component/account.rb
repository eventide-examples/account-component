module AccountComponent
  class Account
    include Schema::DataStructure

    attribute :id, String
    attribute :balance, Numeric, default: 0

    def deposit(amount)
      self.balance += amount
    end

    def withdraw(amount)
      # TODO Deduct amount from balance
    end
  end
end
