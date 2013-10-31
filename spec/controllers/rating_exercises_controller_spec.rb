require 'spec_helper'

describe RatingExercisesController do
  include Devise::TestHelpers

  let(:user) { FactoryGirl.create(:user) }
  before(:each) do
    sign_in(user)
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "renders the 'new' template" do
      get 'new'
      response.should render_template :new
    end

    it "assigns a RatingExercise" do
      get 'new'
      assigns(:rating_exercises).should be_a RatingExercise
    end

    it "redirects to the 'sign_in' page if a user isn't logged in" do
      sign_out(user)
      get 'new'
      response.should redirect_to new_user_session_path
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      post 'create'
      response.should be_success
    end

    it "creates a RatingExercise" do
      expect { post 'create' }.to change { RatingExercise.count }.by(1)
    end
  end
end
