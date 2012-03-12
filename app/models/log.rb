class Log < ActiveRecord::Base
  belongs_to :task
  validates_presence_of :task
  
  validates :actual, :numericality => true
  validates :billable, :numericality => true
  validate :end_after_start

  
  def actual
    return self[:actual].to_f if self[:actual]
    
    if self[:start]
      if self[:end]
        return hours(self[:start].to_datetime,self[:end].to_datetime)
      else
        return hours(self[:start].to_datetime,DateTime.now)
      end    
    end
    0.0
  end

  def billable
    return self[:billable].to_f if self[:billable]
    actual 
  end
  
  def end_after_start
    if self[:end] && (self[:end] < self[:start])
      self.errors.add :base, "End time must be after the start time."
    end
  end

  private

  def hours(s,e)
    diff = ((e-s) * 24).to_f
    (diff*10).ceil/10.0
  end
end
