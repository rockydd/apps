class BalancesController < ApplicationController
  before_filter :login_required
  def index
    @bal = current_user.balance.nil? ? 0 : current_user.balance.amount
    @total = current_user.payments.inject(0){|t, i| t = t + i.amount}
    @unconfirmed = current_user.payments.find_all{|p| ! p.confirmed}.inject(0){|t, i| t = t + i.amount }

    @balances = Balance.find(:all, :order => "amount desc")
    @due = find_pay_people(current_user.id, @bal, @balances)
    respond_to do |format|
      format.html
      format.xml { render :xml => @bal }
    end
  end

private
  def find_pay_people(user_id, my_balance, balances)
    return [] if my_balance == 0
    balances = balances.reverse if my_balance > 0
    res = []
    left = my_balance
    balances.each do |bal|
      raise "Seems that DB has integrity issue" if bal.user_id == user_id
      left = left + bal.amount
      if left * my_balance <= 0  #done
        res << {:user => bal.user, :amount => bal.amount - left}
        return res
      else
        res << {:user => bal.user, :amount => bal.amount }
      end
    end
    return res
  end
end
