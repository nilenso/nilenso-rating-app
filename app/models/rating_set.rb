class RatingSet < ActiveRecord::Base
  belongs_to :user
  belongs_to :rating_exercise

  has_many :ratings

  validates_uniqueness_of :user_id, scope: :rating_exercise_id, allow_nil: false

  accepts_nested_attributes_for :ratings

  def initialize_ratings!
    User.all.each { |user| ratings.find_or_initialize_by(rated_user_id: user.id) }
  end

  def percentage_rating_for_user(user)
    total = ratings.map(&:value).reduce(:+)
    rating_for(user).value / total.to_f * 100
  end

  def rating_for(user)
    ratings.find_by_rated_user_id(user.id)
  end
end
