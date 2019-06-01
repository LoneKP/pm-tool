require "sidekiq/web"
Rails.application.routes.draw do
  root "pages#landing_page"

  resources :projects do
    resources :risk_actions, only: %i[index create new]
    get :choose_data_sources, to: 'projects#choose_data_sources'
    get :connect_harvest_projects, to: 'projects#connect_harvest_projects'
    get :connect_asana_projects, to: 'projects#connect_asana_projects'
    patch :adjust_harvest_projects, to: 'projects#adjust_harvest_projects'
    get :adjust_harvest_projects, to: 'projects#adjust_harvest_projects'
    get :adjust_asana_projects, to: 'projects#adjust_asana_projects'
  end

  resources :risk_actions, only: %i[edit update destroy]

  resources :organisations do
    resources :users, only: %i[create new]
    get :connect_to_tools
    get :new_from_invitation, to: "users#new_from_invitation"
    post :create_from_invitation, to: "users#create_from_invitation"
  end

  resources :users do
    get :done
    resources :invitations, only: %i[create new]
  end

  post :create_set_up, to: "sessions#create_set_up"

  get "login", to: "sessions#new"
  post "login", to: "sessions#create_log_in"
  delete "logout", to: "sessions#destroy", as: "logout"

  get "/projects_on_dashboard", to: "projects#index"
  get "/active_projects", to: "projects#index"

  get "closed_projects", to: "projects#closed_projects"
  get "team", to: "projects#team"
  get "dashboard", to: "projects#dashboard"
  get "projects", to: "projects#projects"

  mount Sidekiq::Web => "/sidekiq"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
