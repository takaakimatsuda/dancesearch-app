class ProfilesController < ApplicationController
  def destroy_image
    current_user.avatar.detach
    redirect_to user_path(current_user), notice: '画像を削除しました。'
  end

  private
    def promotion_params
      params.require(:promotion).permit(:id, :content)
    end
end
