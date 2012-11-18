require Rails.root.join('app','constraints', 'supported_services_constraint.rb')

CapsuleBackend::Application.routes.draw do
  api version: 1 do
    resources :sessions, only: [:create, :destroy]

    resources :users, except: [:edit] do
      resources :capsules, only: [:new, :index, :create]
    end

    scope "/users/:user_id/:service/", constraints: SupportedServicesConstraint do
      resources :accounts, except: [:edit, :show]
    end
    
    resources :capsules, only: [:index, :show, :destroy, :update, :create]
    get '/capsules/search/:search_query' => 'capsules#search'
    
  end

  get "welcome" => "welcome#index"

  apipie

  # http://app-host.com/ leads to ->
  root :to => 'welcome#index'
end
