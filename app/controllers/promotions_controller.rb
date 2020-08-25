class PromotionsController < ApplicationController

  def create
    user = User.find(params[:user_id])
    @promotion = user.promotions.build(promotion_params)
    @promotion.writer_id = current_user.id
    if @promotion.save
      @promotion.create_notification_promotion!(current_user, @promotion.id)
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    Promotion.find_by(id: params[:id],user_id: params[:user_id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private
    def promotion_params
      params.require(:promotion).permit(:id, :content)
    end
end
