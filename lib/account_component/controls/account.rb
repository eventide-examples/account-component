module AccountComponent
  module Controls
    module Account
      def self.example(balance: nil, sequence: nil)
        balance ||= self.balance

        account = AccountComponent::Account.build

        account.id = id
        account.balance = balance
        account.opened_time = Time::Effective::Raw.example

        account.sequence = sequence unless sequence.nil?

        account
      end

      def self.id
        ID.example(increment: id_increment)
      end

      def self.id_increment
        11
      end

      def self.balance
        Money.example
      end

      module New
        def self.example
          AccountComponent::Account.build
        end
      end

      module Open
        def self.example
          Account.example
        end
      end

      module Balance
        def self.example
          Account.example(balance: self.amount)
        end

        def self.amount
          11.1
        end
      end

      module Sequence
        def self.example
          sequence = Controls::Sequence.example

          Account.example(sequence: sequence)
        end
      end

      module Closed
        def self.example
          account = Account.example
          account.closed_time = Time::Effective::Raw.example
          account
        end
      end
    end
  end
end
