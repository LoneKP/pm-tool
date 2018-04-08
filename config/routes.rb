Rails.application.routes.draw do
	root 'projects#index' 
	resources :projects, except: :show
	resources :archived_projects
	
	
	get 'revenue', to: 'projects#revenue'
	get 'all-projects', to: "projects#all_projects"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
