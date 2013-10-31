class RatingSet < ActiveRecord::Base
  belongs_to :user
  belongs_to :rating_exercise
end
