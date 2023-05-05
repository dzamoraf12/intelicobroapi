Rails.application.routes.draw do
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

  resources :restaurant_types, only: %i[index] do
    collection do
      get "/actives", to: "restaurant_types#actives"
      post "/:id/update_icon", to: "restaurant_types#update_icon"
      post "/:id/update_picture", to: "restaurant_types#update_picture"
    end
  end

  resources :restaurants, only: %i[index show] do
    collection do
      post "/:id/update_logo", to: "restaurants#update_logo"
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
