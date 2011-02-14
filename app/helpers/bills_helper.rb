module BillsHelper
  # returns a short (lenngth <= len) summary string, that allows the user to identify the bill in a list. 
  def summary_string(bill, len)
    result = "";
    bill.teams.each_with_index do |team, i|
      if i != 0
        result += ","
      end
      result += " "+ (team.get_display_name)
    end
    truncate(result, :length => len, :omission => "...")
  end  
  
  def format_amount(n)
    sprintf("%0.02f", n)
  end
end
