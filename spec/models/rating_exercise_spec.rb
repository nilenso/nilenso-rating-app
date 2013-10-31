require 'spec_helper'

describe RatingExercise do
  context "when calculating the rating for each user" do
    it "adds up all the percentage ratings for that user" do
      first_user = FactoryGirl.create(:user)
      second_user = FactoryGirl.create(:user)
      rating_exercise = FactoryGirl.create(:rating_exercise)

      first_rating_set = FactoryGirl.create(:rating_set, rating_exercise: rating_exercise, user: first_user)
      FactoryGirl.create(:rating, value: 10, rating_set: first_rating_set, rated_user: first_user)
      FactoryGirl.create(:rating, value: 30, rating_set: first_rating_set, rated_user: second_user)

      second_rating_set = FactoryGirl.create(:rating_set, rating_exercise: rating_exercise, user: second_user)
      FactoryGirl.create(:rating, value: 1500, rating_set: second_rating_set, rated_user: first_user)
      FactoryGirl.create(:rating, value: 1000, rating_set: second_rating_set, rated_user: second_user)

      rating_exercise.ratings_grouped_by_user.should == { first_user => 85, second_user => 115 }
    end
  end
end
