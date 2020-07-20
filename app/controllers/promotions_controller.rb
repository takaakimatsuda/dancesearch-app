class PromotionsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    @promotion = user.promotions.build(promotion_params)
    @promotion.writer_id = current_user.id
    binding.pry
    if @promotion.save
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
      params.require(:promotion).permit(:content)
    end
end
