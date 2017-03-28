Rails.application.routes.draw do


  root 'welcome#index'
  get 'admin', :to => 'users#index'

  #login/ logout routes
  get '/login', to: 'user/signin/login#login'
  post '/attempt_login', to: 'user/signin/login#attempt_login'
  get '/logout', to: 'user/signin/login#logout'

  #signup routes
  get '/signup/patient', to: 'user/signup/register#registerPatient'
  get '/signup/emp', to: 'user/signup/register#registerEmp'
  post '/signup', to: 'user/signup/register#create'


  #patients routes
  get '/patient/home/:id', to: 'patient/home#show'
  get '/patient/profile/:id', to: 'patient/patient_details#edit'
  patch '/patient/update', to: 'patient/patient_details#update'

  #patient Vitals routes
  get '/patient/vital/:id', to: 'patient/vitals#show'
  get '/patient/vital/edit/:id', to: 'patient/vitals#edit'
  patch '/patient/vital/update/:id', to: 'patient/vitals#update'

  #appointment routes
  get '/appointments/search', to: 'appointment/search_appointments#show'

  post '/appointment/search', to: 'appointment/search_appointments#search'
  get '/appointment/add/:id', to: 'appointment/search_appointments#create'


  #doctor routes
  get '/doctor/home/:id', to: 'doctor/home#show'
  get '/doctor/profile/:id', to: 'doctor/doctor_details#edit'
  patch '/doctor/update/:id', to: 'doctor/doctor_details#update'



  #staff routes
  get '/staff/home/:id', to: 'staff/home#show'
  get '/staff/home/:id', to: 'staff/home#show'
  get '/staff/profile/:id', to: 'staff/staff_details#edit'
  patch '/staff/update/:id', to: 'staff/staff_details#update'


  #timeslot routes
  get '/timeslot/new/:id', to: 'timeslot/add_availability#new'

  post '/timeslot/add/:id', to: 'timeslot/add_availability#create'


  #resources




end



# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html