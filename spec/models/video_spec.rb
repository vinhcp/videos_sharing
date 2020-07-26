require 'rails_helper'

RSpec.describe Video do
  describe 'associations' do
    it { should belong_to(:user).class_name('User') }
  end

  describe 'validations' do
    it { should validate_presence_of(:youtube_url) }
    it { should validate_uniqueness_of(:youtube_url).case_insensitive }
    it { should allow_value(build(:video).youtube_url).for(:youtube_url) }
    it { should_not allow_value('https://youtube.com').for(:youtube_url) }
  end

  describe '#set_info' do
    it 'get information from youtube api', vcr: true do
      VCR.use_cassette('youtube_metadata') do
        video = create(:video, user: create(:user))
        expect(video.youtube_embed_url).not_to be_nil
      end
    end
  end
end
