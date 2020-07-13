class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # deviseコントローラーにストロングパラメータを追加する
  before_action :configure_permitted_parameters, if: :devise_controller?

  

    def configure_permitted_parameters
      # サインアップ時にnameとavatarのストロングパラメータを追加
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :avatar])
    end
      # ログイン後、home/indexに移動する
    def after_sign_in_path_for(resource)
      root_path
    end
end
