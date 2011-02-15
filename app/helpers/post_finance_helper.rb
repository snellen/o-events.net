module PostFinanceHelper 
  # Get pspid as string in a format suitable for sending in the post finance payment submit form.
  def pspid()
    PostFinanceController.pspid()
  end
  
  # Get orderID as string in a format suitable for sending in the post finance payment submit form.
  def orderID(bill)
    raise "Fatal internal error while generating payment from!" if bill.reference_number.size > 30
    bill.reference_number
  end
    
  # Get amount in CHF as string in a format suitable for sending in the post finance payment submit form.
  def amount(bill)
    (PostFinanceController.totalInCHF(bill)*100).round(0,BigDecimal::ROUND_UP).to_int().to_s()
  end
  
  # Get currency as string in a format suitable for sending in the post finance payment submit form.
  def currency(bill)
    "CHF" # postfinance accepts only CHF...
  end
  
  # Get customer name as string in a format suitable for sending in the post finance payment submit form.
  def CN(bill)
    truncate(bill.user.full_name, :length => 35, :omission => "")
  end
  
  # Get customer email as string in a format suitable for sending in the post finance payment submit form.
  def EMAIL(bill)
    truncate(bill.user.full_name, :length => 50, :omission => "")
  end
  
  # Get customer address as string in a format suitable for sending in the post finance payment submit form.
  def owneraddress(bill)
    truncate(bill.user.address_line_1+", "+bill.user.address_line_2, :length => 35, :omission => "")
  end
  
  # Get customer zip code as string in a format suitable for sending in the post finance payment submit form.
  def ownerZIP(bill)
    truncate(bill.user.zipcode, :length => 10, :omission => "")
  end
  
  # Get customer country as string in a format suitable for sending in the post finance payment submit form.
  def ownercty(bill)
    bill.user.country.iso_code
  end
  
  # Get customer town (city) as string in a format suitable for sending in the post finance payment submit form.
  def ownertown(bill)
    truncate(bill.user.city, :length => 25, :omission => "")
  end
  
  # Get customer phone number as string in a format suitable for sending in the post finance payment submit form.
  def ownertelno(bill)
    ph = bill.user.phone
    ph ? truncate(ph, :length => 30, :omission => "") : ""
  end
  
  # Get bill comment as string in a format suitable for sending in the post finance payment submit form.
  def bill_comment(bill)
    list = ""
    bill.teams.each_with_index do |team, i|
          if i != 0
            list += ", "
          end
          list += (team.get_display_name())
    end
    truncate(t('.postfinancebillcomment', :event_name => bill.event.name, :registration_list => list), :length => 100, :omission => "...")
  end
    
  # Get sha signature as string in a format suitable for sending in the post finance payment submit form.
  def SHASign(bill)
    PostFinanceController.calculateSHAInSignature(orderID(bill),  
                                                 amount(bill), 
                                                 currency(bill), 
                                                 pspid(),
                                                 {:operation => operation(bill)})
  end
  
  # Title shown to the customer on the payment page of post finance
  def title(bill)
    "Zahlung für O-Events.net"
  end
  
  def operation(bill)
    "SAL"
  end
end
