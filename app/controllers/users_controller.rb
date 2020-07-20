class UsersController < ApplicationController
  before_action :set_user, only: %i[show stocks favoites edit follows followers]

  def index
  end

  def show
    @user = User.find(params[:id])
    @promotions = @user.promotions
    @promotion = Promotion.new
    @promotions = Promotion.page(params[:page]).per(3)
  end

  def edit
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end