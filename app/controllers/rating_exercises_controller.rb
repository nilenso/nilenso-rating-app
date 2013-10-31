class RatingExercisesController < ApplicationController
  def new
    @rating_exercise = RatingExercise.new
  end

  def create
    RatingExercise.create
    render nothing: true
  end
end
