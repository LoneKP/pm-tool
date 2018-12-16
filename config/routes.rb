require 'sidekiq/web'
Rails.application.routes.draw do

	root 'pages#landing_page' 

	#	get '/setup/setup-organisation', to: 'setup_steps#setup_organisation'
	get '/setup/setup-organisation' => 'setup_steps#setup_organisation'





	get '/setup/connect-to-tools', to: 'setup_steps#connect_to_tools'
	get '/setup/sign-in', to: 'setup_steps#sign_in'
	get '/setup/create-user', to: 'setup_steps#create_user'
	get '/setup/invite-colleagues', to: 'setup_steps#invite_colleagues'
	get '/setup/done', to: 'setup_steps#done'

	resources :projects do
		resources :risk_actions, only: [:index, :create, :new]
	end

	resources :projects do
		resources :revenue_months
	end

	resources :risk_actions, only: [:edit, :update, :destroy]
	resources :organisations

	get '/organisations/:id', to: 'setup_steps#connect_to_tools'

	get '/harvest_oauth2/callback', to: 'sessions#create'
	get '/projects_on_dashboard', to: 'projects#index'
	get '/active_projects', to: 'projects#index'
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

