class RatingExercisesController < ApplicationController
  def new
    @rating_exercise = RatingExercise.new
  end

  def create
    rating_exercise = RatingExercise.new(rating_exercise_params)
    if rating_exercise.save
      flash[:notice] = "Exercise successfully created."
      redirect_to rating_exercises_path
    else
      flash.now[:error] = "Error while creating the exercise."
      render :new
    end
  end

  def index
    @rating_exercises = RatingExercise.all
  end

  private

  def rating_exercise_params
    params.require(:rating_exercise).permit(:name)
  end
end
