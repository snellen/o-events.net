class PaymentLogEntry < ActiveRecord::Base
  belongs_to :payment
  belongs_to :payment_log_entry
  validates_presence_of :payment, :unless => "payment_id.blank?"
  validates_presence_of :payment_log_entry, :unless => "payment_log_entry_id.blank?"
  validates_numericality_of :severity, :less_than => 5, :greater_than => 0, :only_integer => true
  validates_presence_of :controller_name
  validates_presence_of :action
  validates_presence_of :ip_address
end
