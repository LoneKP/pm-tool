require 'sidekiq/web'
Rails.application.routes.draw do

	root 'projects#dashboard' 
	resources :projects do
		resources :risk_actions, only: [:index, :create, :new]
	end

	resources :projects do
		resources :revenue_months
	end

	resources :risk_actions, only: [:edit, :update, :destroy]
	

	get 'login', to: 'sessions#new'
	post 'login', to: 'sessions#create'
	delete 'logout', to: 'sessions#destroy', as:  'logout'
	get 'closed_projects', to: 'projects#closed_projects'
	get 'revenue', to: 'projects#revenue'
	get 'team', to: 'projects#team'
	get 'dashboard', to: "projects#dashboard"
	get 'projects', to: "projects#projects"

	mount Sidekiq::Web => '/sidekiq'
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

