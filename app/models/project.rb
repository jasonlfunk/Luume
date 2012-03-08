class Project < ActiveRecord::Base
  belongs_to :client
  has_many :tasks
  has_attached_file :picture, :styles => { :thumb => "75x75!", :medium => "256x256!" }
end
