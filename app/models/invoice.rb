class Invoice < ActiveRecord::Base
  belongs_to :project
  has_many :invoice_entries, :dependent => :destroy
  
  def total_hours 
    tot = 0
    self.invoice_entries.each do |entry|
      tot += entry.hours
    end
    return tot
  end
  def total_amount
    tot = 0
    self.invoice_entries.each do |entry|
      tot += entry.hours * entry.rate
    end
    return tot
  end
end
