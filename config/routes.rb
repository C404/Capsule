Capsule::Application.routes.draw do

  # users devise path
  devise_for :users

  # User profile views
  # get "profile/profile"
  match '/profile/:user_id/profile' => 'profile#profile', as: 'user_profile', via: :get
  get "profile/me"
  get "profile/search"
  get "profile/all"


# match callback providers to omni_callback controller
  match '/auth/facebook/callback', to: 'omniauth#facebook'
  match '/auth/dailymotion/callback', to: 'omniauth#dailymotion'
  match '/auth/twitter/callback', to: 'omniauth#twitter'

  # set put routes to callback
  put "omniauth/dailymotion"
  put "omniauth/facebook"
  put "omniauth/twitter"

  # User registring step
  get "profile/step"
  match 'profile/validate_step' => 'profile#validate_step', as: 'validate_step', via: :put

  # Capsules msg and comments
  resources :capsuls do
    resources :comments
  end

  # home index welcome page
  get "home/index"

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
