Rails.application.routes.draw do
  namespace :site do
    get 'welcome/index'
    get 'search', to: 'search#questions'
  end
  namespace :users_backoffice do
    get 'welcome/index'
  end
  namespace :admins_backoffice do
    get 'welcome/index' #Dashboard
    resources :admins #Admins table
    resources :topics #Topics table
    resources :questions #Questions
  end
  
  devise_for :users
  devise_for :admins
  get 'site/welcome/index'

  root to: 'site/welcome#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
