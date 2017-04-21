module AccountComponent
  class Account
    include Schema::DataStructure

    attribute :id, String
    attribute :balance, Numeric, default: 0

    def deposit(amount)
      self.balance += amount
    end

    def withdraw(amount)
      self.balance -= amount
    end

    def sufficient_funds?(amount)
      # TODO Balance must be greater than or equal to amount
    end
  end
end
