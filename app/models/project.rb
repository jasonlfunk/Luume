class Project < ActiveRecord::Base
  belongs_to :client
  has_many :tasks
  has_attached_file :picture,
                    :default_url => "/images/default/:style/project.png",
                    :styles => { :original => "256x256#", :thumb => "75x75#" }
end
