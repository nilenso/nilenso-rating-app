class RatingSet < ActiveRecord::Base
  belongs_to :user
  belongs_to :rating_exercise

  has_many :ratings

  validates_uniqueness_of :user_id, scope: :rating_exercise_id

  accepts_nested_attributes_for :ratings

  def initialize_ratings!
    User.all.each { |user| ratings.find_or_initialize_by(rated_user_id: user.id) }
  end
end
