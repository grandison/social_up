class Alarm < ActiveRecord::Base
  attr_accessible :time, :user_id

  belongs_to :user
  has_many :music_sets

  def top_music_set
    music_sets.order("likes_count").first.try(:url)
  end

  def as_json(options = {})
    super(methods: :top_music_set)
  end
end
