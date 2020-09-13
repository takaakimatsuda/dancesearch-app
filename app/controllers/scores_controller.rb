class ScoresController < ApplicationController
  def create
    user = User.find(params[:user_id])
    @score = user.scores.build(score_params)
    @score.writer = current_user
    if @score.save
      redirect_to user_path(user), notice: 'スコアを入れました！'
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
