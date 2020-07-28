class ScoresController < ApplicationController
  def create
    user = User.find(params[:user_id])
    @score = user.scores.build(score_params)
    @score.writer_id = current_user.id
    if @score.save
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy;end

  private
    def score_params
      params.require(:score).permit(:point)
    end
end
