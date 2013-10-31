NilensoRatingApp::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  root to: "rating_exercises#index"

  resources :rating_exercises, only: [:new, :create, :index] do
    get 'rate', to: "rating_sets#edit"
    member { get 'summary' }
    resources :rating_sets, only: [:update]
  end

end
