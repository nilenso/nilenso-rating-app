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
      assigns(:rating_exercise).should be_a RatingExercise
    end

    it "redirects to the 'sign_in' page if a user isn't logged in" do
      sign_out(user)
      get 'new'
      response.should redirect_to new_user_session_path
    end
  end

  describe "GET 'create'" do
    it "creates a RatingExercise" do
      expect { post 'create', rating_exercise: { name: "Foo" } }.to change { RatingExercise.count }.by(1)
    end

    it "creates a RatingExercise with the given name" do
      post 'create', rating_exercise: { name: "Foo" }
      RatingExercise.last.name.should == "Foo"
    end

    context "when the save is successful" do
      it "sets a flash notice" do
        post 'create', rating_exercise: { name: "Foo" }
        flash[:notice].should_not be_empty
      end

      it "redirects to the rating_exercises index page" do
        post 'create', rating_exercise: { name: "Foo" }
        response.should redirect_to rating_exercises_path
      end
    end

    context "when the save is unsuccessful" do
      before(:each) do
        RatingExercise.any_instance.stub(:save).and_return(false)
      end

      it "sets a flash error" do
        post 'create', rating_exercise: { name: "Foo" }
        flash[:error].should_not be_empty
      end

      it "renders the 'new' template" do
        post 'create', rating_exercise: { name: "Foo" }
        response.should render_template :new
      end
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end

    it "renders the 'index' template" do
      get 'index'
      response.should render_template :index
    end

    it "assigns an array of RatingExercises" do
      rating_exercises = FactoryGirl.create_list(:rating_exercise, 5)
      get 'index'
      assigns(:rating_exercises).should == rating_exercises
    end

    it "redirects to the 'sign_in' page if a user isn't logged in" do
      sign_out(user)
      get 'index'
      response.should redirect_to new_user_session_path
    end
  end

  describe "GET 'summary'" do
    it "assigns all ratings entered for the exercise" do
      rating_exercise = FactoryGirl.create(:rating_exercise)
      rating_set = FactoryGirl.create(:rating_set, rating_exercise: rating_exercise)
      ratings = FactoryGirl.create_list(:rating, 5, value: 10, rating_set: rating_set)
      get 'summary', id: rating_exercise.id
      assigns(:ratings).should == ratings
    end
  end
end
