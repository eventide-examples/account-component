module AccountComponent
  class Account
    include Schema::DataStructure

    attribute :id, String
    attribute :customer_id, String
    attribute :balance, Numeric, default: 0
    attribute :opened_time, Time

    def open?
      !opened_time.nil?
    end

    def closed?
      # TODO Implement
    end

    def deposit(amount)
      self.balance += amount
    end

    def withdraw(amount)
      self.balance -= amount
    end

    def sufficient_funds?(amount)
      balance >= amount
    end
  end
end
