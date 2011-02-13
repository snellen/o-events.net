class PostFinanceController < ApplicationController
  def payment_accepted
  end

  def payment_declined
  end

  def payment_canceled
  end

  def payment_exception
  end

  def post_sale
  end
  
  def self.pspid()
    POSTFINANCE_PSP_ID
  end
  
  # Hashes the concatenation of the fields and the postfinance SHA-IN "additional string"
  # See 10.1 SHA-IN SIGNATURE in Advanced e-Commerce - Technical integration guide for e-Commerce – Version 3.4
  def self.calculateSHAInSignature(order_id,amount,currency,pspid,optional_fields)
    string = order_id
    string += amount
    string += currency
    string += pspid
    optional_fields[:operation] && (string += optional_fields[:operation])
    string += POSTFINANCE_SHA_IN_SECRET
    puts string
    (Digest::SHA1.hexdigest(string)).upcase()
  end
  
  private
  
  def checkSHAOutSignature(params)
    sig == calculateSHAOutSignature(fields)
  end
  
  # Hashes the concatenation of the fields and the postfinance SHA-OUT "additional string"
  # See 10.2 SHA-OUT SIGNATURE in Advanced e-Commerce - Technical integration guide for e-Commerce – Version 3.4
  def calculateSHAOutSignature(order_id,amount,currency,pspid,payment_method, acceptance, status,cardno, payid, ncerror, brand)
    string = order_id
    string += amount
    string += currency
    string += pspid
    string += payment_method
    string += acceptance
    string += status
    string += cardno
    string += payid
    string += ncerror
    string += brand
    string += POSTFINANCE_SHA_OUT_SECRET
    (Digest::SHA1.hexdigest(string)).upcase()
  end
  
end
