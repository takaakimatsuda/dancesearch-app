# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!, only: %i[edit]
  before_action :check_guest, only: %i[edit destroy]

  def check_guest
    if resource.email == 'guest@example.com'
      redirect_to users_path, notice: 'ゲストユーザーの編集・削除はできません。'
    end
  end
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource

  # GET /resource/edit
   def edit
    @promotions = current_user.promotions.page(params[:page]).per(5)
    super
    current_user.lessons.build     
   end

  
   # def update
   #   super
   # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  private
  def user_params
      params.require(:user).permit(:email, :name, :avatar, lessons_attributes: 
      [:id, :title, :fee, :level, :place, :url, :online, :_destroy])
  end

  protected
  # アカウント編集後、プロフィール画面に移動する
  def after_update_path_for(resource)
    user_path(current_user)
  end
end
