class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[show]
  before_action :set_user, only: %i[show stocks favoites edit follows followers]

  def index
    @q = User.ransack(params[:q])
    if @q
      @users = @q.result(distinct: true).page(params[:page]).per(20)
    else
      # 検索フォーム以外からアクセスした時の処理
      params[:q] = { sorts: 'id desc' }
      @users = User.all.page(params[:page]).per(20)
    end
  end

  def show
    @promotions = @user.promotions.page(params[:page]).per(5)
    # formで呼び出すときに使う
    @promotion = Promotion.new
    @scores = @user.total_score
    # formで呼び出すときに使う
    @score = Score.new
  end

  def follows
    @scores = @user.total_score
    @users = @user.followings.page(params[:page]).per(20)
  end

  def followers
    @scores = @user.total_score
    @users = @user.followers.page(params[:page]).per(20)
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