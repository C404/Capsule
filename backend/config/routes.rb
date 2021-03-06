require Rails.root.join('app','constraints', 'supported_services_constraint.rb')

CapsuleBackend::Application.routes.draw do
  api version: 1 do
    delete '/sessions' => 'sessions#destroy'
    resources :sessions, only: [:create, :destroy]

    resources :users, except: [:edit] do
      resources :capsules, only: [:new, :index, :create]
    end

    scope "/users/:user_id/:service", constraints: SupportedServicesConstraint do
      resources :accounts, except: [:edit, :show, :create]
    end
    
    resources :capsules, only: [:index, :show, :destroy, :update, :create]
    get '/capsules/search/:search_query' => 'capsules#search'
    
  end

  get "welcome" => "welcome#index"

  apipie

  # http://app-host.com/ leads to ->
  
  get "/accounts/:service/*callback/callback" => 'accounts#new'
  get "/accounts/:service/*auth_callback_param/auth_callback" => 'accounts#auth_callback' , :as => 'auth_callback' 
  root :to => 'welcome#index'
end
