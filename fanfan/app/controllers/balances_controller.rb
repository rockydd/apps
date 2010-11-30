class BalancesController < ApplicationController
  before_filter :login_required
  def index
    @bal = current_user.balance.nil? ? 0 : current_user.balance.amount

    respond_to do |format|
      format.html
      format.xml { render :xml => @bal }
    end
  end
end
