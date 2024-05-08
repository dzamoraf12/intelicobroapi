Rails.application.routes.draw do
  resources :visits
  devise_for :users,
             controllers: {
               sessions: "users/sessions",
               registrations: "users/registrations"
             },
             defaults: { format: :json }
  get "/member/data", to: "members#show"
  post "/members/update_personal_data", to: "members#update_personal_data"
  post "/members/update_avatar", to: "members#update_avatar"
  get "/members/reset_password", to: "member_views#reset_password"

  resources :customers, only: [:index, :show]
  resources :prospects do
    collection do
      get :dashboard
    end
  end

  get '/tracks/stream', to: 'visits#stream'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
