require 'rails_helper'

describe 'Video list' do
  let(:user_1) { create(:user) }
  let(:user_2) { create(:user, email: 'example@example.com') }
  context 'when user go to homepage' do
    it 'see a list of videos' do
      VCR.use_cassette('youtube_metadata') do
        create(:video, user: user_1)
        create(:video, user: user_2)
      end
      visit root_path
      expect(page).to have_selector('.video-item', count: 2)
      expect(page).to have_selector('.video-detail .shared-by', text: "Shared by #{user_1.email}")
      expect(page).to have_selector('.video-detail .shared-by', text: "Shared by #{user_2.email}")
    end
  end
end
