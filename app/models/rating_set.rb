class RatingSet < ActiveRecord::Base
  belongs_to :user
  belongs_to :rating_exercise

  has_many :ratings

  validates_uniqueness_of :user_id, scope: :rating_exercise_id

  accepts_nested_attributes_for :ratings
end
