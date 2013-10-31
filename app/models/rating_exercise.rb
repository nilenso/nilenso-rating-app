class RatingExercise < ActiveRecord::Base
  has_many :rating_sets

  def ratings_grouped_by_user
    User.all.reduce({}) do |memo, user|
      memo[user] = rating_sets.map { |rating_set| rating_set.percentage_rating_for_user(user) }.reduce(:+)
      memo
    end
  end
end
