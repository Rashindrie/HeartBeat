Rails.application.routes.draw do
  root 'welcome#index'


  get '/signup', to: 'users#new'
  get 'users/login', to: 'users#login'
  post '/attempt_login', to: 'users#attempt_login'
  delete 'logout', to: 'users#logout'

  get '/signup/patient', to: 'users#registerPatient'
  get '/signup/emp', to: 'users#registerEmp'


  get 'admin', :to => 'users#index'

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
