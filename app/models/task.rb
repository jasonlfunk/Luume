class Task < ActiveRecord::Base
  belongs_to :project
  
  validates_presence_of :name
  validates_uniqueness_of :name, 
                          :scope => :project_id,
                          :case_sensitive => false,
                          :message => "already exists in this project"

  validates_presence_of :description
  validates_presence_of :project

  has_many :logs, :order => "start DESC", :dependent => :destroy

  def actual
    total = 0.0
    self.logs.each do |log|
      total += log.actual
    end 
    total
  end

  def billable
    total = 0.0
    self.logs.each do |log|
      total += log.billable
    end 
    total
  end
  
  def running?
    !self.logs.find(:all, :conditions => { :end => nil }).empty?
  end
end
