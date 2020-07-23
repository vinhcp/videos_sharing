class Video < ApplicationRecord
  belongs_to :user

  validates_presence_of :youtube_url

  before_create :set_info

  private

  def set_info
    info = VideoInfo.new(youtube_url)
    self.youtube_title = info.title
    self.youtube_embed_url = info.embed_url
    self.youtube_description = info.description
  end
end
