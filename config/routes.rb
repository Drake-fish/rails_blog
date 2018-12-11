Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts
  resources :users, except: [:new]
  root 'pages#home'
  # get 'about', to: 'welcome#about'
  get 'signup', to: 'users#new'

end
