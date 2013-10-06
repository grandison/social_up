class MusicSet < ActiveRecord::Base
  attr_accessible :title, :aid, :url, :author
  belongs_to :alarm
  has_many :likes

  validates :title, :aid, :url, presence: true
end
