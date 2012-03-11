class Task < ActiveRecord::Base
  belongs_to :project, :dependent => :destroy
  
  validates_presence_of :name
  validates_uniqueness_of :name, 
                          :scope => :project_id,
                          :case_sensitive => false,
                          :message => "already exists in this project"
  validates_presence_of :description
  validates_presence_of :project

  has_many :logs
end
