class Bank < ActiveRecord::Base
  belongs_to :company
  
  has_one :address, :as => :addressable, :dependent => :destroy
  accepts_nested_attributes_for :address, :allow_destroy => true
  
  validates :company_account_number,:name, :presence => true

  def complete_address
    address.complete_address if address
  end
end