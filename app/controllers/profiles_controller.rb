class ProfilesController < ApplicationController
  def destroy_image
    current_user.avatar.detach
    redirect_to edit_user_registration_path, notice: '画像を削除しました。'
  end
end
