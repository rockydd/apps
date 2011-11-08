module BalanceLib
  def calculate_balance(activity)
    activity.payments.each do  |payment|
      balance = payment.user.balance || Balance.new(:user => payment.user, :amount=>0)
      balance.amount += activity.balance_of_user(payment.user)
      balance.save
    end
  end
end
