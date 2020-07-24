require 'rails_helper'

RSpec.describe Video do
  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
  end

  describe 'validations' do
    it { should validate_presence_of(:youtube_url) }
  end

  describe '#set_info' do
    it 'get information from youtube api', vcr: true do
      VCR.use_cassette('youtube_metadata') do
        video = create(:video, user: create(:user))
        puts video.inspect
        expect(video.youtube_embed_url).not_to be_nil
      end
    end
  end
end
