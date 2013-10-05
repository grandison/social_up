class User < ActiveRecord::Base
  attr_accessible :name, :token

  has_many :alarms
end
