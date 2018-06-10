Rails.application.routes.draw do
	root 'projects#index' 
	resources :projects do
		resources :risk_actions
	end



	get 'revenue', to: 'projects#revenue'
	get 'dashboard', to: "projects#dashboard"
	get 'projects', to: "projects#projects"


	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
