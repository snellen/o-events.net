class EbankingController < ApplicationController
  def show
    @user = User.get_logged_in(session)
    @bill = @user.bills.where(:id => params[:bill]).first
  end

  def self.calculatePaymentFees(bill)
    0
  end
  
  def self.total(bill)
    bill.amount
  end
  
  def self.enabledForEvent(event)
    EventSetting.get_b('payment_ebanking_enable',Event.find(event))
  end
  
  
end
