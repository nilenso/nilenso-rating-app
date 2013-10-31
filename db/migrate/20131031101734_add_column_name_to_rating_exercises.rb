class AddColumnNameToRatingExercises < ActiveRecord::Migration
  def change
    add_column :rating_exercises, :name, :string
  end
end
