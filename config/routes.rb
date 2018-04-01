Rails.application.routes.draw do
	root 'projects#index' 
	resources :projects, except: :show
	resources :projects, path_names: { new: 'all-projects'}
	
	get 'about', to: 'projects#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
