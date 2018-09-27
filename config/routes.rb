Rails.application.routes.draw do
	root 'projects#dashboard' 
	resources :projects do
		resources :risk_actions, only: [:index, :create, :new]
	end

	resources :projects do
		resources :revenue_months
	end

	resources :risk_actions, only: [:edit, :update, :destroy]


	get 'archived_projects', to: 'projects#archived_projects'
	get 'revenue', to: 'projects#revenue'
	get 'dashboard', to: "projects#dashboard"
	get 'projects', to: "projects#projects"


	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
