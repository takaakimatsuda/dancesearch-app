class ScoresController < ApplicationController
  def create
    user = User.find(params[:user_id])
    @score = user.scores.build(score_params)
    @score.writer_id = current_user.id
    if @score.save
      redirect_to user_path(params[:user_id]), notice: "スコアを入れました！"
      # redirect_back(fallback_location: root_path)
    else
      flash[:alert] = @score.errors.full_messages.join('。')
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy;end

  private
    def score_params
      params.require(:score).permit(:point)
    end
end
