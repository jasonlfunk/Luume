Luume::Application.routes.draw do

  get 'profile' => 'users#edit', :as => :profile
  
  put 'profile' => 'users#update', :as => :profile_save
  
  get 'signup' => 'users#new', :as => :signup
  
  post 'signup' => 'users#create', :as => :signup_create
  
  match 'logout' => 'sessions#destroy', :as => :logout
  
  match 'login' => 'sessions#new', :as => :login

  post 'projects/:id/generate' => 'projects#generate', :as => :generate_invoice 

  get 'users/status' => 'users#status', :as => :user_status

  resources :sessions

  resources :users

  get "home/index"
  
  resources :clients

  resources :projects do
    resources :invoices
    resources :tasks do
       match 'start' => 'log#start', :as => :start
       match 'stop' => 'log#stop', :as => :stop
      resources :logs
    end
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
