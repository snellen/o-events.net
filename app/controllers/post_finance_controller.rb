class PostFinanceController < ApplicationController
  skip_before_filter :authorize  
  before_filter :paramsKeysToUpcase
  
  # Convert parameter names of parameters relevant for the transaction feedback (namely parmeters contained in ECOMMERCE_FEEDBACK_PARAMETERS)
  # to upercase.
  # This ensures some independence of the implementation on the side of post finance.
  def paramsKeysToUpcase
    origParams = params
    origParams.each_pair do |param,value|
      upParam = param.upcase()
      if ECOMMERCE_FEEDBACK_PARAMETERS.include? upParam and !params[upParam]
        params.delete(param)
        params[upParam] = value
      end 
    end
  end
  
  # Log message severity
  class Severity
    INFO = 1
    WARNING = 2
    ERROR = 3
    FATAL = 4
  end
  
  # Create new log entry, sets controller_name, action, and ip_address,
  # but entry is not saved into db
  # param reqLog log entry generated will be associated with this entry
  def PREPARE_PAYMENT_LOG_ENTRY(assocLog, action)
    logEntry = PaymentLogEntry.new()
    logEntry.controller_name = PostFinanceController.name 
    logEntry.action = action
    logEntry.ip_address = request.remote_ip
    if assocLog
      logEntry.payment_log_entry = assocLog
    end
    logEntry
  end
  
  # Log a request to action
  def PAYMENT_LOG_REQUEST(action, params)
    logEntry = PREPARE_PAYMENT_LOG_ENTRY(nil, action)
    logEntry.severity = Severity::INFO
    paramsString = ""
    params.each_pair{|k,v| paramsString += (k != params.keys.first ? ", ":"")+k+" => "+v}
    envString = ""
    request.env.each_pair{|k,v| envString += (k != request.env.keys.first ? ", ":"")+k+" => "+v.to_s()}
    logEntry.message = ("Got request: "+envString+", params:"+paramsString)[ 0 .. 10000] 
    logEntry.save
    logEntry
  end
  
  # logs a message to the payment log
  def PAYMENT_LOG_MESSAGE(assocLog, action, severity, message, payment)
    log = PREPARE_PAYMENT_LOG_ENTRY(assocLog, action)
    log.severity = severity
    if payment 
      log.payment = payment
    end
    log.message = message
    log.save
  end
    
  def payment_accepted
    reqLog = PAYMENT_LOG_REQUEST(__method__, params)
    begin
      if checkSHAOutSignature(reqLog, params)
        payment = processPayment(reqLog, __method__, params)
        message = payment ? t('.paymentsuccessful'): t('.paymentfailed')
        if redirectToBill(params, message)
          return
        end
      else
        PAYMENT_LOG_MESSAGE(reqLog,__method__,Severity::ERROR,"Hash check failed!",nil)
      end
    rescue => e
      PAYMENT_LOG_MESSAGE(reqLog,__method__,Severity::FATAL,"Exception: "+e.to_s()+" bt: "+e.backtrace.to_s(),nil)
    end
    respond_to do |format|
      format.html { redirect_to bills_url, :notice => t('.paymentfailedinternalerror') }
    end
  end

  def payment_declined
    reqLog = PAYMENT_LOG_REQUEST(__method__, params)
    begin
      if checkSHAOutSignature(reqLog,params)
        ncerror = params["NCERROR"]
        msg = "Payment for "+params["ORDERID"]+" declined (status "+params["STATUS"]+(ncerror ? ", error code "+ncerror : "")
        PAYMENT_LOG_MESSAGE(reqLog,__method__,Severity::WARNING,msg,nil)
        msg = t('.paymentdeclined')
        if !(bill = redirectToBill(params, msg))
          redirectToBills(msg) # should not happen unless the bill reference number is invalid, but just in case
        else
          increaseAbortCount(bill)
        end
        return
      else
        PAYMENT_LOG_MESSAGE(reqLog,__method__,Severity::ERROR,"Hash check failed!",nil)
      end
    rescue => e
      PAYMENT_LOG_MESSAGE(reqLog,__method__,Severity::FATAL,"Exception: "+e.to_s()+" bt: "+e.backtrace.to_s(),nil)
    end
    respond_to do |format|
      format.html { redirect_to bills_url, :notice => t('.paymentfailedinternalerror') }
    end
  end

  def payment_canceled
    reqLog = PAYMENT_LOG_REQUEST(__method__, params)
    begin
      if checkSHAOutSignature(reqLog,params)
        ncerror = params["NCERROR"]
        msg = "Payment for "+params["ORDERID"]+" canceled (status "+params["STATUS"]+")"+(ncerror ? ", error code "+ncerror : "")
        PAYMENT_LOG_MESSAGE(reqLog,__method__,Severity::INFO,msg,nil)
        msg = t('.paymentcanceled')
        if !(bill = redirectToBill(params, msg))
          redirectToBills(msg) # should not happen unless the bill reference number is invalid, but just in case
        else
          increaseAbortCount(bill)
        end
        return
      else
        PAYMENT_LOG_MESSAGE(reqLog,__method__,Severity::ERROR,"Hash check failed!",nil)
      end
    rescue => e
      PAYMENT_LOG_MESSAGE(reqLog,__method__,Severity::FATAL,"Exception: "+e.to_s()+" bt: "+e.backtrace.to_s(),nil)
    end
    respond_to do |format|
      format.html { redirect_to bills_url, :notice => t('.paymentfailedinternalerror') }
    end
  end

  def payment_exception
    reqLog = PAYMENT_LOG_REQUEST(__method__, params)
    begin
      if checkSHAOutSignature(reqLog,params)
        ncerror = params["NCERROR"]
        msg = "Payment for "+params["ORDERID"]+" exception (status "+params["STATUS"]+")"+(ncerror ? ", error code "+ncerror : "")
        PAYMENT_LOG_MESSAGE(reqLog,__method__,Severity::WARNING,msg,nil)
        msg = t('.paymentuncertain')
        if !(bill = redirectToBill(params, msg))
          redirectToBills(msg) # should not happen unless the bill reference number is invalid, but just in case
        else
          increaseAbortCount(bill)
        end
        return
      else
        PAYMENT_LOG_MESSAGE(reqLog,__method__,Severity::ERROR,"Hash check failed!",nil)
      end
    rescue => e
      PAYMENT_LOG_MESSAGE(reqLog,__method__,Severity::FATAL,"Exception: "+e.to_s()+" bt: "+e.backtrace.to_s(),nil)
    end
    respond_to do |format|
      format.html { redirect_to bills_url, :notice => t('.paymentfailedinternalerror') }
    end
  end

  def post_sale
    reqLog = PAYMENT_LOG_REQUEST(__method__, params)
    begin
      if checkSHAOutSignature(reqLog, params)
        payment = processPayment(reqLog, __method__, params)
      else
        PAYMENT_LOG_MESSAGE(reqLog,__method__,Severity::ERROR,"Hash check failed!",nil)
      end
    rescue => e
      PAYMENT_LOG_MESSAGE(reqLog,__method__,Severity::FATAL,"Exception: "+e.to_s()+" bt: "+e.backtrace.to_s(),nil)
    end
  end

  # return the PSPID to be used for payments  
  def self.pspid()
    POSTFINANCE_PSP_ID
  end
  
  # Hashes the fields with the SHA-IN Passphrase
  # See 11.1 SHA-1-IN signature in Advanced e-Commerce - Technical integration guide for e-Commerce - Version 5.0
  def self.calculateSHAInSignature(fields)
    calculateSignature(fields, POSTFINANCE_SHA_IN_SECRET)
  end
  
  # Hashes the fields with the SHA-OUT Passphrase
  # See 11.1 SHA-1-IN signature in Advanced e-Commerce - Technical integration guide for e-Commerce - Version 5.0
  def self.calculateSHAOutSignature(fields)
    calculateSignature(fields, POSTFINANCE_SHA_OUT_SECRET)
  end
  
  # Calculate the fees to be added to the event fee if the organizer does not cover the fees
  # amount always in CHF
  def self.calculatePaymentFeesInCHF(amount)
    transactionFee = BigDecimal.new("0.38") # basic fee
    microPaymentComissionRate = BigDecimal.new("1.5") # %
    paymentComissionRate = BigDecimal.new("2.0") # %
    paymentComissionMax = BigDecimal.new("6") # CHF
    if(amount < 25)
      transactionFee += amount*microPaymentComissionRate/100
    else
      transactionFee += [amount*paymentComissionRate/100, paymentComissionMax].min
    end
    transactionFee.round(2,BigDecimal::ROUND_UP)
    return transactionFee
  end
    
  # Calculate total amount of the bill (including fees if not covered by the event organizer)
  def self.totalInCHF(bill)
    amount = bill.amountInCHF
    if EventSetting.get_b('payment_postfinance_coverfees',Event.find(bill.event)) == false
      amount += PostFinanceController.calculatePaymentFeesInCHF(amount)
    end
    return amount
  end
  
  def self.enabledForEvent(event)
    EventSetting.get_b('payment_postfinance_enable',Event.find(event))
  end
    
  def self.initBill(bill)
    addInfos = bill.additional_bill_informations.where(:name => abortCountName)
    if addInfos.size == 0 
      addInfo = AdditionalBillInformation.new(:name => abortCountName, :value => 0.to_s, :bill => bill)
      addInfo.save
    end
  end
    
  def self.getFullReferenceNumber(bill)
    initBill(bill)
    (bill.reference_number.to_s + PostFinanceController.getAbortCountFmt(bill))[0..29]
  end
  
  private
  
  # Concatenates all key, value pairs in fields in the format {key=value}secretString and hashes the resulting string with SHA512
  # see Chapter 11 Appendix: SHA in e-Commerce Advanced Technical Integration Guide for e-Commerce v.5.0
  def self.calculateSignature(fields, secretString)
    fieldsSorted = fields.sort()
    string = ""
    for item in fieldsSorted.each do
      if(item[1].size > 0)
        string += item[0].upcase()+"="+item[1]+secretString
      end
    end
    (Digest::SHA512.hexdigest(string)).upcase()
  end
  
  # true => ok, false => not ok
  def checkSHAOutSignature(reqLog, params)
    fields = params.reject { |key,_| !ECOMMERCE_FEEDBACK_PARAMETERS.include? key}
    params["SHASIGN"] == PostFinanceController.calculateSHAOutSignature(fields)
  end
  
  # Return payment instance created if payment accepted
  # param reqLog all log entries generated will be associated with this entry
  # param params the parameters of the request
  # param the name of the action that invoked this method (user for logging)  
  def processPayment(reqLog, action, params)
    refNum = params["ORDERID"]
    bill = getBillByRefnum(refNum)
    if !bill
      message = "Invalid reference_number: "+refNum
      PAYMENT_LOG_MESSAGE(reqLog,action,Severity::WARNING,message,nil)
      return nil
    end
    amount = params["AMOUNT"]
    status = params["STATUS"]
    currencyCode = params["CURRENCY"]
    pm = params["PM"]
    payments = bill.payments.where(:method => ["postfinance_card", "postfinance_efinance"])
    if payments.size > 0
      message = "Ignoring duplicate payment with ref number "+refNum+", amount "+amount+" "+currencyCode
      PAYMENT_LOG_MESSAGE(reqLog,action,Severity::INFO,message,payments.first)
      return payments.first
    end
    
    if status == "9"
      curr = Currency.where(:iso_code => currencyCode)
      if curr.size == 1
        newPayment = enterPayment(reqLog,action,refNum,bill, params["AMOUNT"], curr.first, status, pm)
        if newPayment
          checkBillPaid(newPayment,bill)
        end
        return newPayment
      else
        message = "Received payment for "+refNum+" with unknown currency: "+currencyCode+", status "+status
        PAYMENT_LOG_MESSAGE(reqLog,action,Severity::ERROR,message,nil)
        return nil
      end
    else
      ncerror = params["NCERROR"]
      message = "Ignoring payment for "+refNum+", status "+status+(ncerror ? ", error code "+ncerror : "")
      PAYMENT_LOG_MESSAGE(reqLog,action,Severity::WARNING,message,nil)
      return nil
    end
  end
  
  def enterPayment(reqLog, action, refNum, bill, amount, currency, status, pm)
    regTime = Time.now()
    payment = Payment.new()
    payment.reference_number = refNum
    payment.valuta = calcValuta(regTime)
    payment.fees_valuta = calcValuta(regTime)
    payment.registration_time = regTime
    payment.method = translatePaymentMethod(pm)
    payment.fees = PostFinanceController.calculatePaymentFeesInCHF(bill.amountInCHF) # post finance payments always cover the entire bill...
    payment.amount = amount
    payment.bill = bill
    payment.currency = currency
    if payment.save
      message = "Received payment for "+refNum+", status "+ status
      PAYMENT_LOG_MESSAGE(reqLog,action,Severity::INFO,message,payment)
      return payment
    else
      errors = ""
      payment.errors.full_messages.each_with_index do |msg,i|
        if i != 0
          errors += ", "
        end
        errors += msg
      end
      message = "Could not save payment for "+refNum + ". Errors: "+errors
      PAYMENT_LOG_MESSAGE(reqLog,action,Severity::FATAL,message,nil)
      return nil
    end
  end
  
  # Check if bill is paid and update status of bill
  def checkBillPaid(payment, bill)
    billAmount = PostFinanceController.totalInCHF(bill)
    # Since the amount of the bill is rounded up in the payment form that is sent to post finance,
    # the amount of the incoming payment should be at least the amount of the bill (or more).
    if(payment.amount - billAmount >= BigDecimal.new("0.0") and !bill.is_paid)
      bill.is_paid = true
      bill.save
    end
  end
  
  # Calculate the estimated valuta of payments based on the time given.
  def calcValuta(time)
    dayOffset = 0
    if time.wday == 0 # Sunday
      dayOffset = 1
    elsif time.wday == 6 # Saturday
      dayOffset = 2
    elsif time.wday == 5 # Friday
      dayOffset = 3
    end
    time += dayOffset.days
    return time
  end
    
  # Translate postfinance payment method names to internal names
  # returns the value passed as parameter if there is no translation defined
  def translatePaymentMethod(pm)
    if(pm == "PostFinance Card")
      return "postfinance_card"
    elsif(pm == "PostFinance e-finance")
      return "postfinance_efinance"
    else 
      return pm
    end
  end
  
  def getBillByRefnum(refNum)
    bills = Bill.where(:reference_number => removeAbortCountFromRefnum(refNum))
    if bills.size != 1
      return nil
    else
      return bills.first
    end
  end
  
  def redirectToBill(p, notice)
    refNum = p["ORDERID"]
    bill = getBillByRefnum(refNum)
    if bill
      respond_to do |format|
        format.html { redirect_to bill_url(bill.id), :notice => notice }
      end
    end
    return bill
  end
  
  def redirectToBills(notice)
    respond_to do |format|
      format.html { redirect_to bills_url, :notice => notice }
    end
  end
    
  # Get formated abort count
  # max length 4
  def self.getAbortCountFmt(bill)
    addInfo = bill.additional_bill_informations.where(:name => PostFinanceController.abortCountName()).first
    ("-"+addInfo.value)[0..3]
  end
    
  # Increase abort count
  def increaseAbortCount(bill)
    addInfo = bill.additional_bill_informations.where(:name => PostFinanceController.abortCountName()).first
    i = Integer(addInfo.value)
    i = i + 1
    addInfo.value = i
    addInfo.save
  end
  
  def removeAbortCountFromRefnum(refNum)
    refNum[0..25]
  end

  def self.abortCountName()
    "abort_count"
  end

end
