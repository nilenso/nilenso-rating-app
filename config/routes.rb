NilensoRatingApp::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resources :rating_exercise
end
