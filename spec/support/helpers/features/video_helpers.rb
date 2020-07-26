module Features
  module VideoHelpers
    def share_video(youtube_url:)
      visit new_video_path
      fill_in 'video_youtube_url', with: youtube_url
      click_on 'Share'
    end
  end
end
