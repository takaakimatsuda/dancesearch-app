class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # deviseコントローラーにストロングパラメータを追加する
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search

  # ログイン後の遷移先を変更
  def after_sign_in_path_for(resource)
    root_path
  end

  def set_search
    @q = User.ransack(params[:q])
    if @q
    @users = @q.result(distinct: true).page(params[:page]).per(20)
    else
      @users = User.all.page(params[:page]).per(20)
    end
  end

  protected

  # サインアップ時にnameとavatarのストロングパラメータを追加
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar])
      devise_parameter_sanitizer.permit(:account_update, 
      keys: [
      :name,
      :genre,
      :avatar,
      :team_name,
      :pref1,
      :pref2,
      :pref3,
      :carrer,
      :lesson_comment,
      :movie_url,
      :promotion_url,
      :promotion_title,
      :twitter_url,
      :instagram_url,
      :facebook_url,
      lessons_attributes:[:id, :title, :fee, :time, :level, :place, :url, :online, :_destroy]]
      )
    end

  private
    def sign_in_required
      redirect_to new_user_session_url unless user_signed_in?
    end

end
