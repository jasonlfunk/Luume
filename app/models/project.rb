class Project < ActiveRecord::Base
  belongs_to :client
  validates_presence_of :client

  has_many :tasks, :order => "name ASC", :dependent => :destroy
  has_many :invoices

  has_attached_file :picture,
                    :default_url => "/images/default/:style/project.png",
                    :styles => { :original => "256x256#", :thumb => "75x75#" }

  def running?
    self.tasks.each do |task|
      return true unless task.logs.find(:all, :conditions => { :end => nil }).empty?
    end
    false
  end

  def time(type,uninvoiced = true)
    total = 0.0
    self.tasks.each do |task|
      task.logs.find_all{|l| uninvoiced ? !l.invoiced : true}.each do |log|
        if type == "actual"
          total += log.actual
        elsif type == "billable"
          total += log.billable
        end
      end
    end 
    total
  end
end
