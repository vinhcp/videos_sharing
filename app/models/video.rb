class Video < ApplicationRecord
  YOUTUBE_REGEX = %r{\A^https:\/\/www\.youtube\.com\/watch\?v=([a-zA-Z0-9_-]*)\Z}.freeze
  belongs_to :user

  validates_presence_of :youtube_url
  validates_format_of :youtube_url, with: YOUTUBE_REGEX, on: :create

  before_create :set_info

  private

  def set_info
    info = VideoInfo.new(youtube_url)
    self.youtube_title = info.title
    self.youtube_embed_url = info.embed_url
    self.youtube_description = info.description
  end
end
