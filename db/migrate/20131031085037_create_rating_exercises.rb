class CreateRatingExercises < ActiveRecord::Migration
  def change
    create_table :rating_exercises do |t|

      t.timestamps
    end
  end
end
