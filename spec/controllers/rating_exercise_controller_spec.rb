require 'spec_helper'

describe RatingExerciseController do
  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "renders the 'new' template" do
      get 'new'
      response.should render_template :new
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
