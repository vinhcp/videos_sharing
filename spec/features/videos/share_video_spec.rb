require 'rails_helper'

describe 'Share a video' do
  let(:user) { create(:user) }
  let(:video) { build(:video) }

  context 'As guest user' do
    it 'cannot share a video' do
      visit new_video_path
      expect(page).to have_content('You need to sign in or sign up before continuing.')
      expect(page).to have_selector("input[value='Login / Register']")
    end
  end

  context 'As a logged-in user' do
    before { login_user(user: user) }

    context 'share valid youtube url' do
      it 'share movie successfully' do
        VCR.use_cassette('youtube_metadata') do
          share_video(youtube_url: video.youtube_url)
          expect(page).to have_content('Share youtube movie successfully')
          expect(page).to have_selector('.video-item', count: 1)
          expect(page).to have_selector('.video-detail .shared-by', text: "Shared by #{user.email}")
        end
      end
    end

    context 'share invalid youtube url' do
      it 'should have error message' do
        share_video(youtube_url: 'https://youtube.com')
        expect(page).to have_content('Youtube URL is invalid')
      end
    end
  end
end
