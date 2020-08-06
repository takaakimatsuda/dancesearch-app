class UsersController < ApplicationController
  before_action :set_user, only: %i[show stocks favoites edit follows followers]

  def index
    @q = User.ransack(params[:q])
    if @q
    @users = @q.result(distinct: true).page(params[:page]).per(20)
    else
      # 検索フォーム以外からアクセスした時の処理
      params[:q] = { sorts: 'id desc' }
      @q = User.ransack()
      @users = User.all.page(params[:page]).per(20)
    end
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
    # formで呼び出すときに使う
    @promotion = Promotion.new
    @scores = @user.scores.all.sum(:point)
    # formで呼び出すときに使う
    @score = Score.new
    @lessons = @user.lessons.all
  end

  # def search
  #   if params[:q].present?
  #   # 検索フォームからアクセスした時の処理
  #     @q = User.ransack(search_params)
  #     @users = @q.result
  #   else
  #   # 検索フォーム以外からアクセスした時の処理
  #     params[:q] = { sorts: 'id desc' }
  #     @q = User.ransack()
  #     @users = User.all
  #   end
  # end

  def edit
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def search_params
    params.require(:q).permit!
    params[:q] || {
      genre_in: User.public_genres.values
    }
  end
end