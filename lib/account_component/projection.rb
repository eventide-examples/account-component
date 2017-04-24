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

      account.sequence = deposited.sequence
    end

    apply Withdrawn do |withdrawn|
      account.id = withdrawn.account_id

      amount = withdrawn.amount

      account.withdraw(amount)

      account.sequence = withdrawn.sequence
    end

    apply WithdrawalRejected do |withdrawal_rejected|
      account.sequence = withdrawal_rejected.sequence
    end

    apply Closed do |closed|
      closed_time = Time.parse(closed.time)

      account.closed_time = closed_time
    end
  end
end
