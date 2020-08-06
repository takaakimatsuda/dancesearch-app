class AnnouncementsController < ApplicationController
  before_action :set_user, only: %i[show]

  def index
  end

  def show
  end

  def create
  end

  def destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
