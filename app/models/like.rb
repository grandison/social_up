class Like < ActiveRecord::Base
  attr_accessible :music_set_id
  belongs_to :music_set, counter_cache: true
  belongs_to :user
end
