Rails.application.routes.draw do


  root 'welcome#index'
  get 'admin', :to => 'users#index'

  #login/ logout routes
  get '/login', to: 'user/signin/login#login'
  post '/attempt_login', to: 'user/signin/login#attempt_login'
  delete 'logout', to: 'user/signin/login#logout'

  #signup routes
  get '/signup/patient', to: 'user/signup/register#registerPatient'
  get '/signup/emp', to: 'user/signup/register#registerEmp'


  #additional patients routes
 get '/patient/home', to: 'patient/home#show'


  #doctor routes
  get '/doctor/home', to: 'doctor/home#show'

  #staff routes
  get '/staff/home', to: 'staff/home#show'

  #resources
  resources :patients, :staffs


end



# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html