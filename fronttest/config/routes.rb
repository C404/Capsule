BackendMongoid::Application.routes.draw do
  scope "/private" do
    mount RailsAdmin::Engine => '/manage', :as => 'rails_admin'
    devise_for :admin_users
  end

  scope "/api" do
    api version: 1 do
      namespace :hire do
        resources :events, except: [:edit] do
          get 'states'
          resources :containers, only: [:new, :create, :index]
        end

        resources :containers, only: [:show, :update, :destroy] do
          put 'move/:container_id' => "container#move"
          post 'add/:library_item_id' => 'container#add_item'
          put 'forward'
          put 'backward'
          resources :containers, only: [:new, :create, :index]
          resources :gears, except: [:edit, :new, :create] do
            put 'forward/:count' => "gear#forward", defaults: {count: 1}
            put 'backward/:count' => "gear#backward", defaults: {count: 1}
            put 'move/:container_id' => "gear#move"
          end
        end
      end

      namespace :library do
        get 'items/suggests/:word' => "items#suggests"
        get 'items/text_search/:word' => "items#text_search"
        resources :items, only: [:show, :destroy, :update]
        resources :categories, only: [:index, :show] do
          resources :categories, only: [:index]
          resources :items, only: [:index, :new, :create]
        end
      end
    end
  end

  get "ng/:page" => "ng#view"
  get "welcome/index"

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
  root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
