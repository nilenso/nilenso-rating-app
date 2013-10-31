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
end
