require "sidekiq/web"
Rails.application.routes.draw do
  root "pages#landing_page"

  resources :projects do
    resources :risk_actions, only: %i[index create new]
  end

  resources :projects do
    resources :revenue_months
  end

  resources :risk_actions, only: %i[edit update destroy]

  resources :organisations do  
    get :connect_to_tools
    get :sign_in
    resources :users, only: %i[create new]
  end

  resources :users do
    get :invite_colleagues
    get :done
  end

  get "/harvest_oauth2/callback", to: "sessions#create"
  get "/projects_on_dashboard", to: "projects#index"
  get "/active_projects", to: "projects#index"
  get "login", to: "sessions#new"
  post "login", to: "sessions#create"
  delete "logout", to: "sessions#destroy", as: "logout"
  get "closed_projects", to: "projects#closed_projects"
  get "revenue", to: "projects#revenue"
  get "team", to: "projects#team"
  get "dashboard", to: "projects#dashboard"
  get "projects", to: "projects#projects"

  mount Sidekiq::Web => "/sidekiq"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
