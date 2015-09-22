class GoalsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    render :index
  end

  def new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    
    if @goal.save
      redirect_to user_goals_url(current_user.id)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def goal_params
    params.require(:goal).permit(:body)
  end
end
