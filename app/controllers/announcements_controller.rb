class AnnouncementsController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @announcement = Announcement.new
    if @announcements.present?
      @announcements = @user.announcements.page(params[:page]).per(10)
    end
  end

  def show
    @announcement = Announcement.new
    @announcements = @user.announcements.all.page(params[:page]).per(10)
    @scores = @user.scores.all.sum(:point)
  end

  def create
    @announcement = current_user.announcements.build(announcement_params)
    if @announcement.save
      flash[:success] = "announcement created!"
      redirect_to announcements_path
    else
      render 'announcements/index'
    end
  end

  def destroy
  end

  private

    def announcement_params
      params.require(:announcement).permit(:content)
    end

    def set_user
      @user = User.find(params[:id])
    end
end
