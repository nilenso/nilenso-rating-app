class AddColumnRatingExerciseIdToRatingSet < ActiveRecord::Migration
  def change
    add_reference :rating_sets, :rating_exercise, index: true
  end
end
