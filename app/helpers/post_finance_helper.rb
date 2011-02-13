module PostFinanceHelper
  def pspid()
    PostFinanceController.pspid()
  end
  
  def orderID(bill)
    raise "Fatal internal error while generating payment from!" if bill.reference_number.size > 30
    bill.reference_number
  end
  
  def amount(bill)
    ((bill.amount*bill.exchange_rate*100).ceil).to_s()
  end
  
  def currency(bill)
    bill.currency.iso_code
  end
  
  def CN(bill)
    truncate(bill.user.full_name, :length => 35, :omission => "")
  end
  
  def EMAIL(bill)
    truncate(bill.user.full_name, :length => 50, :omission => "")
  end
  
  def owneraddress(bill)
    truncate(bill.user.address_line_1+", "+bill.user.address_line_2, :length => 35, :omission => "")
  end
  
  def ownerZIP(bill)
    truncate(bill.user.zipcode, :length => 10, :omission => "")
  end
  
  def ownercty(bill)
    bill.user.country.iso_code
  end
  
  def ownertown(bill)
    truncate(bill.user.city, :length => 25, :omission => "")
  end
  
  def ownertelno(bill)
    ph = bill.user.phone
    ph ? truncate(ph, :length => 30, :omission => "") : ""
  end
  
  def bill_comment(bill)
    list = ""
    bill.teams.each_with_index do |team, i|
          if i != 0
            list += ", "
          end
          list += (team.get_display_name(' '))
    end
    truncate("Rechnung für Wettkampf '"+bill.event.name+"', Teams/Läufer: "+list, :length => 100, :omission => "...")
  end
    
  def SHASign(bill)
    PostFinanceController.calculateSHAInSignature(orderID(bill),  
                                                 amount(bill), 
                                                 currency(bill), 
                                                 pspid(),
                                                 {:operation => operation(bill)})
  end
  
  def title(bill)
    "Zahlung für O-Events.net"
  end
  
  def operation(bill)
    "SAL"
  end
end
