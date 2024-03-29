class VideosController < ApplicationController
  PER_PAGE = 15
  before_action :authenticate_user!, only: %i[create new]

  def index
    @videos = Video.all.order(created_at: :desc)
                   .page(params[:page] || 1)
                   .per(params[:per_page] || PER_PAGE)
                   .includes(:user)
  end

  def new
    @video = Video.new
  end

  def create
    @video = current_user.videos.new(video_params)
    if @video.save
      flash[:success] = 'Share youtube movie successfully'
      redirect_to root_path
    else
      flash.now[:error] = @video.errors.full_messages.first
      render :new
    end
  end

  private

  def video_params
    params.require(:video).permit(:youtube_url)
  end
end
