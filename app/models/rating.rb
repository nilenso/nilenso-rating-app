class Rating < ActiveRecord::Base
  belongs_to :rating_set
  belongs_to :rated_user, class_name: User

  validates_uniqueness_of :rated_user_id, scope: :rating_set_id

  delegate :email, to: :rated_user, prefix: true
end
