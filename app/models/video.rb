class Video < ApplicationRecord
  belongs_to :user

  validates_presence_of :youtube_url
end
