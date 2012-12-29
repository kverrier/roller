class VideosController < ApplicationController
  def index
    @videos = Video.all
  end

  def new
    @video = Video.new
    @title = "Create new video"
  end

  def create
    @video = Video.new(params[:video])
    if @video.save
      flash[:success] = "Created Video!"
      redirect_to @video
    else
      @title = "Create new video"
      render 'new'
    end
  end

  def show
    @video = Video.find(params[:id])
    @name = @video.name
    @youtube_id = @video.youtube_id
    @start_time = @video.start_time
    @end_time = @video.end_time
  end
end
