class RatingSetsController < ApplicationController
  def edit
    rating_exercise = RatingExercise.find(params[:rating_exercise_id])
    @rating_set = RatingSet.where(user: current_user, rating_exercise: rating_exercise).first_or_create
  end

  def update
  end
end
