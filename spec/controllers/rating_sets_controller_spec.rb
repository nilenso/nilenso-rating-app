require 'spec_helper'

describe RatingSetsController do
  include Devise::TestHelpers

  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    sign_in(user)
  end

  describe "GET 'edit'" do
    let(:rating_exercise) { FactoryGirl.create(:rating_exercise) }

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

  describe "GET 'update'" do
    it "returns http success" do
      get 'update'
      response.should be_success
    end
  end
end
