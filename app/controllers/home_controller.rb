class HomeController < ApplicationController
  def index
    @users = User.order(updated_at: :desc).page(params[:page]).per(3)
  end
end
