require 'spec_helper'

describe RatingSet do
  context "when initializing ratings" do
    it "initializes ratings if they don't exist" do
      user = FactoryGirl.create(:user)
      rating_set = FactoryGirl.create(:rating_set)
      rating_set.initialize_ratings!
      rating_set.ratings.should_not be_empty
    end

    it "initializes ratings with the correct user ID" do
      users = FactoryGirl.create_list(:user, 5)
      rating_set = FactoryGirl.create(:rating_set)
      rating_set.initialize_ratings!
      rating_set.ratings.map(&:rated_user).should =~ users
    end
  end

  context "when finding the rating for a user" do
    it "returns it if a rating exists for that user" do
      user = FactoryGirl.create(:user)
      rating_set = FactoryGirl.create(:rating_set)
      rating = FactoryGirl.create(:rating, rated_user: user, rating_set: rating_set)
      rating_set.rating_for(user).should == rating
    end

    it "returns nil if no rating exists for that user" do
      user = FactoryGirl.create(:user)
      rating_set = FactoryGirl.create(:rating_set)
      rating_set.rating_for(user).should be_nil
    end
  end

  context "when finding the percentage total rating for a user" do
    it "returns 10 if the user's rating is 12 and the total rating is 120" do
      first_user = FactoryGirl.create(:user)
      second_user = FactoryGirl.create(:user)
      rating_set = FactoryGirl.create(:rating_set)
      FactoryGirl.create(:rating, value: 12, rated_user: first_user, rating_set: rating_set)
      FactoryGirl.create(:rating, value: 108, rated_user: second_user, rating_set: rating_set)
      rating_set.percentage_rating_for_user(first_user).should == 10
    end

    it "returns 0.0625 if the user's rating is 1 and the total rating is 16" do
      first_user = FactoryGirl.create(:user)
      second_user = FactoryGirl.create(:user)
      rating_set = FactoryGirl.create(:rating_set)
      FactoryGirl.create(:rating, value: 1, rated_user: first_user, rating_set: rating_set)
      FactoryGirl.create(:rating, value: 15, rated_user: second_user, rating_set: rating_set)
      rating_set.percentage_rating_for_user(first_user).should == 6.25
    end

    it "works okay if some ratings are 'nil'" do
      first_user = FactoryGirl.create(:user)
      second_user = FactoryGirl.create(:user)
      rating_set = FactoryGirl.create(:rating_set)
      FactoryGirl.create(:rating, value: 1, rated_user: first_user, rating_set: rating_set)
      FactoryGirl.create(:rating, value: nil, rated_user: second_user, rating_set: rating_set)
      rating_set.percentage_rating_for_user(first_user).should == 100
    end

    it "works okay if all ratings are 'nil'" do
      first_user = FactoryGirl.create(:user)
      second_user = FactoryGirl.create(:user)
      rating_set = FactoryGirl.create(:rating_set)
      FactoryGirl.create(:rating, value: nil, rated_user: first_user, rating_set: rating_set)
      FactoryGirl.create(:rating, value: nil, rated_user: second_user, rating_set: rating_set)
      rating_set.percentage_rating_for_user(first_user).should == 0
    end
  end
end
