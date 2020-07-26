require 'rails_helper'

RSpec.describe VideosController do
  let(:user) { create(:user) }
  let(:build_video) { build(:video) }
  let(:video) { VCR.use_cassette('youtube_metadata') { create(:video, user: user) } }

  describe 'GET index' do
    it 'return list of videos' do
      get :index
      expect(assigns(:videos)).to eq([video])
    end

    it 'renders the index template' do
      get :index
      expect(response).to have_http_status(:ok)
      assert_template 'videos/index'
    end
  end

  describe 'POST create' do
    context 'when no login' do
      it 'redirects to homepage' do
        post :create
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when login' do
      before do
        sign_in user
      end

      context 'when having valid youtube url' do
        it 'share new video' do
          VCR.use_cassette('youtube_metadata') do
            expect do
              post :create, params: { video: { youtube_url: build_video.youtube_url } }
            end.to change(Video, :count).by(1)
            video = assigns(:video)
            expect(video.youtube_embed_url).not_to be_nil
            expect(response).to redirect_to(root_path)
          end
        end
      end

      context 'when having invalid youtube url' do
        it 'let user enter url again' do
          expect do
            post :create, params: { video: { youtube_url: 'https://youtube.com' } }
          end.to change(Video, :count).by(0)
          assert_template 'videos/new'
        end
      end

      context 'when having existing youtube url' do
        it 'let user enter url again' do
          expect do
            post :create, params: { video: { youtube_url: video.youtube_url } }
          end.to change(Video, :count).by(1)
          assert_template 'videos/new'
        end
      end
    end
  end

  describe 'GET new' do
    context 'when no login' do
      it 'redirects to homepage' do
        get :new
        expect(response).to redirect_to(root_path)
      end
    end

    context 'when login' do
      before do
        sign_in user
      end

      it 'assign new video' do
        get :new
        expect(assigns(:video)).to be_a_new(Video)
      end

      it 'renders the new template' do
        get :new
        expect(response).to have_http_status(:ok)
        assert_template 'videos/new'
      end
    end
  end
end
