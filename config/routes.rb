Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "general#landing"

  devise_scope :user do
   get '/users', to: 'devise/registrations#new'
  end
  devise_for :users, controllers: {
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    unlocks: 'user/unlocks'
  }

  ###############################################
  # ACCOUNTS
  ###############################################

  get '/account', to: 'accounts#show', as: 'account'

  ###############################################
  # JOB LISTINGS
  ###############################################

  get '/jobs', to: 'job_listings#index', as: 'job_listings'
  get '/jobs/:company_name', to: 'job_listings#company', as: 'company_job_listings'

  ###############################################
  # REVIEWS
  ###############################################

  get '/company/:company_id/review/new', to: 'reviews#new', as: 'new_review'
  get '/review/:id/edit', to: 'reviews#edit', as: 'edit_review'
  get '/review/:id', to: 'reviews#show'
  get '/company/:company_id/leadership/:chief_id/review/new', to: 'reviews#new', as: 'new_chief_review'

  put '/review/:id/approve', to: 'reviews#approve', as: 'review_approve'
  put '/review/:id/deny', to: 'reviews#deny', as: 'review_deny'

  patch '/review/:id', to: 'reviews#update', as: 'review'
  post '/companies/:company_id/review/', to: 'reviews#create', as: 'reviews'

  ###############################################
  # NOTES
  ###############################################

  delete '/notes/:id', to: 'notes#destroy', as: 'destroy_note'

  ###############################################
  # COMPANIES
  ###############################################

  resources :companies

  put '/company/:id/approve', to: 'companies#approve', as: 'company_approve'
  put '/company/:id/deny', to: 'companies#deny', as: 'company_deny'

  ###############################################
  # CHIEFS
  ###############################################

  get '/leadership/:id', to: 'chiefs#show', as: 'chief'
  get '/company/:company_id/leadership/new', to: 'chiefs#new', as: 'new_chief'
  get '/company/:company_id/leadership/:id/edit', to: 'chiefs#edit', as: 'edit_chief'

  put '/leadership/:id/approve', to: 'chiefs#approve', as: 'chief_approve'
  put '/leadership/:id/deny', to: 'chiefs#deny', as: 'chief_deny'

  post '/leadership', to: 'chiefs#create', as: 'chiefs'

  ###############################################
  # ADMIN
  ###############################################

  get '/system', to: 'system#index', as: 'system'
  get '/system/users', to: 'system#users', as: 'system_users'
  get '/system/users/:status', to: 'system#users'
  get '/system/companies', to: 'system#companies', as: 'system_companies'
  get '/system/companies/:status', to: 'system#companies'
  get '/system/chiefs', to: 'system#chiefs', as: 'system_chiefs'
  get '/system/chiefs/:status', to: 'system#chiefs'
  get '/system/reviews', to: 'system#reviews', as: 'system_reviews'
  get '/system/reviews/:status', to: 'system#reviews'
  get '/system/admin/new', to: 'system#new_admin', as: 'new_admin'

  get '/moderator', to: 'moderator#index', as: 'moderator'
  put 'moderator/users/:id/deny', to: 'moderator#user_deny', as: 'user_deny'

  get '/admin/account/:id', to: 'accounts#admin_show', as: 'admin_account'

  ###############################################
  # QUEUES
  ###############################################

  get '/moderator/queues', to: 'queues#index', as: 'queues'
  get '/moderator/queues/:queue_type', to: 'queues#index', as: 'queue_items'
end
