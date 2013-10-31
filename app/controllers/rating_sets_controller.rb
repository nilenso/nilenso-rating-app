class RatingSetsController < ApplicationController
  def edit
    @rating_exercise = RatingExercise.find(params[:rating_exercise_id])
    @rating_set = RatingSet.where(user: current_user, rating_exercise: @rating_exercise).first_or_create
    @rating_set.initialize_ratings!
  end

  def update
    rating_set = RatingSet.find(params[:id])
    if rating_set.update(rating_set_params)
      flash[:notice] = "Ratings saved successfully"
      redirect_to rating_exercises_path
    else
      flash.now[:error] = "There was an error while saving your ratings"
      render :edit
    end
  end

  private

  def rating_set_params
    params.require(:rating_set).permit(ratings_attributes: [:id, :value, :rated_user_id])
  end
end
