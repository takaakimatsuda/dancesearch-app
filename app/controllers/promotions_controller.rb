class PromotionsController < ApplicationController

  def create
    user = User.find(params[:user_id])
    @promotion = user.promotions.build(promotion_params)
    @promotion.writer = current_user
    if @promotion.save
      @promotion.create_notification_promotion!(current_user, @promotion.id)
      redirect_to user_path(user), notice: "プロモーションを入力しました。"
    else
      redirect_to user_path(user), alert: "プロモーションを入力してください。"
    end
  end

  def destroy
    Promotion.find_by(id: params[:id], user_id: params[:user_id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private
    def promotion_params
      params.require(:promotion).permit(:id, :content)
    end
end
