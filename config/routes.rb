Rails.application.routes.draw do


  root 'welcome#index'
  get 'admin', :to => 'users#index'

  #login/ logout routes
  get '/login', to: 'user/log_in#login'
  post '/attempt_login', to: 'user/log_in#attempt_login'
  get '/logout', to: 'user/log_in#logout'

  #signup routes
  get '/signup/patient', to: 'user/register#registerPatient'
  get '/signup/emp/:id', to: 'admin/signup_emp#registerEmp'
  get '/signup/admin/:id', to: 'admin/signup_emp#registerAdmin'
  post '/register/emp/:id', to: 'admin/signup_emp#create'
  post '/register/admin/:id', to: 'admin/signup_emp#create'
  post '/signup', to: 'user/register#create'


    #patient Vitals routes
  get '/patient/vital/:id', to: 'vital#show'


  #appointment routes
  get '/appointment/search/:id', to: 'appointment/search_appointments#searchApp'

  post '/appointment/search/:id', to: 'appointment/search_appointments#search'
  post '/appointment/add/:patient_id/:id', to: 'appointment/search_appointments#create'
  post '/waitinglist/add/:patient_id/:id', to: 'appointment/search_appointments#add'

  #patients routes
  get '/patient/home/:id', to: 'patient/home#home'
  get '/patient/profile/:id', to: 'patient/patient_details#edit'
  patch '/patient/update/:id', to: 'patient/patient_details#update'
  get '/patient/appointments/:id', to: 'patient/view_appointments#index'
  patch '/appointment/delete/:patient_id/:id', to: 'patient/view_appointments#update'
  get '/appointment/:patient_id/:id', to: 'patient/view_appointments#show'
  get '/visits/:id', to: 'visits#index'

  get '/organ/donor/:id', to: 'patient/organ_donor#new'
  post '/organ/donor/register/:id', to: 'patient/organ_donor#create'
  get '/organ/requester/register/:id', to: 'patient/organ_requester#new'
  post '/organ/requester/register/:id', to: 'patient/organ_requester#create'
  get '/organ/requester/:id', to: 'patient/organ_requester#index'

  #doctor routes
  get '/doctor/home/:id', to: 'doctor/home#home'
  get '/doctor/profile/:id', to: 'doctor/doctor_details#edit'
  patch '/doctor/update/:id', to: 'doctor/doctor_details#update'
  get '/doctor/organ/donor/:id', to: 'doctor/organ_donor#index'
  post '/doctor/donor/search/:id', to: 'doctor/organ_donor#search'

  get '/doctor/requester/donor/:id', to: 'doctor/organ_requester#index'
  post '/doctor/requester/search/:id', to: 'doctor/organ_requester#search'
  post '/organ/donor/update/:id', to: 'doctor/organ_requester#update'


  #doctor vitals routes
  get '/vital/:doctor_id/:id', to: 'vital#show'
  get '/vital/edit/:doctor_id/:id', to: 'vital#edit'
  patch '/vital/update/:doctor_id/:id', to: 'vital#update'

  #doctor visit routes
  get '/visit/:doctor_id/:id', to: 'visits#index'
  get '/visit/new/:doctor_id/:id', to: 'visits#new'
  post '/visit/add/:doctor_id/:id', to: 'visits#create'

  #doctor view patients
  get '/search/patients/:id', to: 'patient/search_patients#index'
  get '/search/patients/:doctor_id/:id', to: 'patient/search_patients#show'


  #doctor view appointments
  get '/view/appointments/:id', to: 'doctor/view_appointments#show'
  post '/search/appointments/:id', to: 'doctor/view_appointments#searchApp'

  #staff routes
  get '/staff/home/:id', to: 'staff/home#home'
  get '/staff/home/:id', to: 'staff/home#show'
  get '/staff/profile/:id', to: 'staff/staff_details#edit'
  patch '/staff/update/:id', to: 'staff/staff_details#update'


  #add timeslot routes
  get '/timeslot/new/:id', to: 'staff/add_time_slot#new'
  post '/timeslot/add/:id', to: 'staff/add_time_slot#create'

  #view timeslots
  get '/timeslot/show/:id', to: 'staff/view_time_slots#show'
  get '/timeslot/search/:id', to: 'staff/view_time_slots#search'
  patch '/timeslot/cancel/:id', to: 'staff/view_time_slots#update'

  #admin routes

  get 'admin/home/:id', to: 'admin/home#home'
  get '/admin/users/:id', to: 'admin/archive_users#show'
  patch '/admin/users/update/:admin_id/:id', to: 'admin/archive_users#update'

  resources :account_activations, only: [:edit]
end



# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html