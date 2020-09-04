class ProfilesController < ApplicationController
  def destroy_image
    current_user.avatar.detach
    redirect_to user_path(current_user), notice: '画像を削除しました。'
  end
end
