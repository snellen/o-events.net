class PaymentLogEntriesController < ApplicationController
  # GET /payment_log_entries
  # GET /payment_log_entries.xml
  def index
    @payment_log_entries = PaymentLogEntry.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @payment_log_entries }
    end
  end

  # GET /payment_log_entries/1
  # GET /payment_log_entries/1.xml
  def show
    @payment_log_entry = PaymentLogEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @payment_log_entry }
    end
  end
end
