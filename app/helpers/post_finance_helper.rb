module PostFinanceHelper
  FormFields = {
    "PSPID" => lambda{|bill| PostFinanceController.pspid()},
    "ORDERID" => lambda{|bill| raise "Fatal internal error while generating payment from!" if bill.reference_number.size > 30
                               bill.reference_number},
    "AMOUNT" => lambda{|bill| (PostFinanceController.totalInCHF(bill)*100).to_int().to_s()},
    "CURRENCY" => lambda{|bill| "CHF"},
    "LANGUAGE" => lambda{|bill| "de_CH"},
    "CN" => lambda{|bill| truncate(bill.user.full_name, :length => 35, :omission => "")},
    "EMAIL" => lambda{|bill| truncate(bill.user.email, :length => 50, :omission => "")}, 
    "OWNERZIP" => lambda{|bill|  truncate(bill.user.zipcode, :length => 10, :omission => "")}, 
    "OWNERADDRESS" => lambda{|bill| truncate(bill.user.address_line_1+", "+bill.user.address_line_2, :length => 35, :omission => "")}, 
    "OWNERCTY" => lambda{|bill| bill.user.country.iso_code},
    "OWNERTOWN" => lambda{|bill| truncate(bill.user.city, :length => 25, :omission => "")},
    "OWNERTELNO" => lambda{|bill| ph = bill.user.phone
                                  ph ? truncate(ph, :length => 30, :omission => "") : ""},
    "COM" => lambda{|bill| 
      list = ""
      bill.teams.each_with_index do |team, i|
            if i != 0
              list += ", "
            end
            list += (team.get_display_name())
      end
      truncate(t('.postfinancebillcomment', :event_name => bill.event.name, :registration_list => list), :length => 100, :omission => "...")},
    "TITLE" => lambda{|bill| "Zahlung für O-Events.net"},
    "ACCEPTURL" => lambda{|bill| post_finance_payment_accepted_url}, 
    "DECLINEURL" => lambda{|bill| post_finance_payment_declined_url },
    "EXCEPTIONURL" => lambda{|bill| post_finance_payment_exception_url },
    "CANCELURL" => lambda{|bill| post_finance_payment_canceled_url },
    "OPERATION" => lambda{|bill| "SAL"}}
   
    
  # Get sha signature as string in a format suitable for sending in the post finance payment submit form.
  def buildFormForBill(bill)
    formHash = {}
    FormFields.each_pair do |name, val|
      formHash[name] = instance_exec(bill, &val)
    end
    formHash[signatureField] = PostFinanceController.calculateSHAInSignature(formHash)
    formHash
  end
  
  def getFieldsList()
    list = []
    FormFields.each_pair do |name, val|
      list << name
    end
    list
  end
  
  def signatureField
    "SHASIGN"
  end
  
  
end
