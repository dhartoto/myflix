class QueueVideosController < ApplicationController
  before_action :require_user

  def index
    #@queue_videos = QueueVideo.where(user: current_user)
    @queue_videos = current_user.queue_videos
  end

  def create
    unless video_in_queue
      QueueVideo.create(video_id: params[:video_id], user: current_user, position: queue_position)
    end
    redirect_to my_queue_path
  end

  private

  def queue_position
    QueueVideo.count + 1
  end

  def video_in_queue
    QueueVideo.find_by(video_id: params[:video_id])
  end

end
