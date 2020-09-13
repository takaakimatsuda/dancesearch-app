class AnnouncementsController < ApplicationController
  before_action :authenticate_user!, only: %i[index show]
  before_action :set_user, only: [:show]

  def index
    @announcement = Announcement.new
    @feed_items = current_user.feed.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @announcements = @user.announcements.all.page(params[:page]).per(10)
    @scores = @user.scores.all.sum(:point)
  end

  def create
    @announcement = current_user.announcements.build(announcement_params)
    if @announcement.save
      redirect_to announcements_path, notice: 'アナウンスを入力しました。'
    else
      redirect_to announcements_path, alert: 'アナウンスを入力してください。'
    end
  end

  def destroy
    announce_ment = current_user.announcements.find(params[:id])
    announce_ment.destroy!
    redirect_back(fallback_location: root_path)
  end

  private

    def announcement_params
      params.require(:announcement).permit(:content)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
