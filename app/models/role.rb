class Role < ActiveRecord::Base
  validates_inclusion_of :role, :in => [:admin]
  belongs_to :user
  validates_presence_of :user
end
