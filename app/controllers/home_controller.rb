class HomeController < ApplicationController
  def index
    @users = User.all.order("updated_at DESC").page(params[:page]).per(3)
  end
end
