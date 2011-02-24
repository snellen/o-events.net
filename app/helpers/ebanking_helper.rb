module EbankingHelper
    
  # return full reference number (including final check digit)
  def getFullReferenceNumber(number)
    return groupRefNumber(number+checkDigit(number))
  end
  
  def groupRefNumber(number)
    number.reverse().scan(/.{1,5}/).join(' ').reverse()
  end
  
  private
  def checkDigit(number)
    table = [0, 9, 4, 6, 8, 2, 7, 1, 3, 5]
    carry = 0
    for digit in number.each_char do
      carry = table[(carry+Integer(digit))%10]
    end
    ((10-carry)%10).to_s
  end
end
