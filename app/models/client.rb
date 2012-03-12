class Client < ActiveRecord::Base
  validates :name, :presence => true
  validates_format_of :email, :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
  has_attached_file :picture, 
                    :default_url => "/images/default/:style/client.png",
                    :styles => { :original => "256x256#", :thumb => "75x75#" }

  has_many :projects, :order => "name ASC", :dependent => :destroy
  belongs_to :user
  validates_presence_of :user
end
