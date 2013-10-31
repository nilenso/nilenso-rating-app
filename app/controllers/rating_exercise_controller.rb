class RatingExerciseController < ApplicationController
  def new
  end

  def create
    RatingExercise.create
    render nothing: true
  end
end
