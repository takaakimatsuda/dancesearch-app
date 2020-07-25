class UsersController < ApplicationController
  before_action :set_user, only: %i[show stocks favoites edit follows followers]

  def index
  end

  def show
    movie_url = @user[:movie_url]
    if movie_url.present?
      movie_url = movie_url.last(11)
    end
    @user.movie_url = movie_url
    twitter_url = @user[:twitter_url]
    if twitter_url.present?
      twitter_url = twitter_url.delete("@")
    end
    @user.twitter_url = twitter_url
    @promotions = @user.promotions.page(params[:page]).per(5)
    @promotion = Promotion.new
  end

  def edit
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

end