require 'spec_helper'

describe RatingSetsController do
  include Devise::TestHelpers

  let(:user) { FactoryGirl.create(:user) }
  let(:rating_exercise) { FactoryGirl.create(:rating_exercise) }

  before(:each) do
    sign_in(user)
  end

  describe "GET 'edit'" do

    it "returns http success" do
      get 'edit', rating_exercise_id: rating_exercise.id
      response.should be_success
    end

    it "renders the 'edit' template" do
      get 'edit', rating_exercise_id: rating_exercise.id
      response.should render_template :edit
    end

    it "assigns a rating set" do
      get 'edit', rating_exercise_id: rating_exercise.id
      assigns(:rating_set).should be_a RatingSet
    end

    it "assigns a rating set belonging to the rating exercise" do
      get 'edit', rating_exercise_id: rating_exercise.id
      assigns(:rating_set).rating_exercise.should == rating_exercise
    end

    it "raises an error if the passed ID is invalid" do
      expect { get 'edit', rating_exercise_id: 1234 }.to raise_error
    end

    it "redirects to the 'sign_in' page if a user isn't logged in" do
      sign_out(user)
      get 'edit', rating_exercise_id: rating_exercise.id
      response.should redirect_to new_user_session_path
    end
  end

  describe "PUT 'update'" do
    it "updates the ratings" do
      rating_set = FactoryGirl.create(:rating_set)
      rating = FactoryGirl.create(:rating, rating_set: rating_set)
      ratings_attributes = { "0" => { :value => 10, :id => rating.id }}
      put 'update', rating_exercise_id: rating_exercise.id, id: rating_set.id, :rating_set => { ratings_attributes: ratings_attributes }
      rating.reload.value.should == 10
    end

    context "when save is successful" do
      it "sets a flash notice" do
        rating_set = FactoryGirl.create(:rating_set)
        put 'update', rating_exercise_id: rating_exercise.id, id: rating_set.id, rating_set: { ratings_attributes: nil }
        flash[:notice].should_not be_empty
      end

      it "redirects to the index page" do
        rating_set = FactoryGirl.create(:rating_set)
        put 'update', rating_exercise_id: rating_exercise.id, id: rating_set.id, rating_set: { ratings_attributes: nil }
        response.should redirect_to rating_exercises_path
      end
    end

    context "when save is unsuccessful" do
      before(:each) do
        RatingSet.any_instance.stub(:update).and_return(false)
      end

      it "sets a flash error" do
        rating_set = FactoryGirl.create(:rating_set)
        put 'update', rating_exercise_id: rating_exercise.id, id: rating_set.id, rating_set: { ratings_attributes: nil }
        flash[:error].should_not be_empty
      end

      it "renders the 'edit' template" do
        rating_set = FactoryGirl.create(:rating_set)
        put 'update', rating_exercise_id: rating_exercise.id, id: rating_set.id, rating_set: { ratings_attributes: nil }
        response.should render_template :edit
      end
    end
  end
end
