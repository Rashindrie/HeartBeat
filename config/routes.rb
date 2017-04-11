Rails.application.routes.draw do


  root 'welcome#index'
  get 'admin', :to => 'users#index'

  #login/ logout routes
  get '/login', to: 'user/log_in#login'
  post '/attempt_login', to: 'user/log_in#attempt_login'
  get '/logout', to: 'user/log_in#logout'

  #signup routes
  get '/signup/patient', to: 'user/register#registerPatient'
  get '/signup/emp', to: 'user/register#registerEmp'
  post '/signup', to: 'user/register#create'


  #patients routes
  get '/patient/home/:id', to: 'patient/home#home'
  get '/patient/profile/:id', to: 'patient/patient_details#edit'
  patch '/patient/update', to: 'patient/patient_details#update'

  #patient Vitals routes
  get '/patient/vital/:id', to: 'vital#show'


  #appointment routes
  get '/appointment/search', to: 'appointment/search_appointments#searchApp'

  post '/appointment/search', to: 'appointment/search_appointments#search'
  get '/appointment/add/:id', to: 'appointment/search_appointments#create'


  #doctor routes
  get '/doctor/home/:id', to: 'doctor/home#home'
  get '/doctor/profile/:id', to: 'doctor/doctor_details#edit'
  patch '/doctor/update/:id', to: 'doctor/doctor_details#update'

  #doctor vitals routes
  get '/vital/:id', to: 'vital#show'
  get '/vital/edit/:id', to: 'vital#edit'
  patch '/vital/update/:id', to: 'vital#update'

  #doctor view patients
  get '/search/patients', to: 'patient/search_patients#index'

  #doctor view appointments
  get '/view/appointments', to: 'doctor/view_appointments#show'
  post '/view/appointments', to: 'doctor/view_appointments#searchApp'

  #staff routes
  get '/staff/home/:id', to: 'staff/home#home'
  get '/staff/home/:id', to: 'staff/home#show'
  get '/staff/profile/:id', to: 'staff/staff_details#edit'
  patch '/staff/update/:id', to: 'staff/staff_details#update'


  #add timeslot routes
  get '/timeslot/new/:id', to: 'staff/add_time_slot#new'
  post '/timeslot/add/:id', to: 'staff/add_time_slot#create'

  #view timeslots
  get '/timeslot/show', to: 'staff/view_time_slots#show'
  post '/timeslot/searchApp', to: 'staff/view_time_slots#searchApp'


  #resources




end



# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html