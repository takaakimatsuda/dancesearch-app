class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # deviseコントローラーにストロングパラメータを追加する
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      # サインアップ時にnameのストロングパラメータを追加
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
      # アカウント編集の時にname等のストロングパラメータを追加
      devise_parameter_sanitizer.permit(:account_update, keys: [:name])
    end
      # ログイン後、home/indexに移動する
    def after_sign_in_path_for(resource)
      root_path
    end
end
