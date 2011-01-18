class Payment < ActiveRecord::Base
  belongs_to :payment_group
  belongs_to :currency
end
