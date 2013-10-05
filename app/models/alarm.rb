class Alarm < ActiveRecord::Base
  attr_accessible :time, :user_id

  belongs_to :user
  has_many :music_sets
end
