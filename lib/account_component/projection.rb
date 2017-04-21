module AccountComponent
  class Projection
    include EntityProjection
    include Messages::Events

    entity_name :account

    apply Deposited do |deposited|
      account.id = deposited.account_id

      amount = deposited.amount

      account.deposit(amount)
    end

    apply Withdrawn do |withdrawn|
      account.id = withdrawn.account_id

      amount = withdrawn.amount

      account.withdraw(amount)
    end
  end
end
