# Dynamic e-Commerce Parameters.
# These fields are expected to be present in the transaction feedback.
# Must contain NCERROR, PAYID, ORDERID, STATUS, AMOUNT, CURRENCY, PM 
# Must be uppercase!
ECOMMERCE_FEEDBACK_PARAMETERS = ["ACCEPTANCE", "AMOUNT", "BRAND", "CARDNO", "CURRENCY", "NCERROR", "ORDERID", "PAYID", "PM", "STATUS", "TRXDATE"]

# Reduced test values...
#ECOMMERCE_FEEDBACK_PARAMETERS = ["AMOUNT","CURRENCY", "NCERROR", "ORDERID", "PAYID", "STATUS", "PM"]

