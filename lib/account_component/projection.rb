module AccountComponent
  class Projection
    include EntityProjection
    include Messages::Events

    entity_name :account

    apply Opened do |opened|
      account.id = opened.account_id
      account.customer_id = opened.customer_id

      opened_time = Time.parse(opened.time)

      account.opened_time = opened_time
    end

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
