Rails.application.routes.draw do
	root 'projects#home'
	
	get 'about', to: 'projects#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
