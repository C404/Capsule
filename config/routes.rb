Capsule::Application.routes.draw do

  # auth and all sessions / connect controllers
  match '/auth/facebook/callback', to: 'omniauth#facebook'
  match '/auth/dailymotion/callback', to: 'omniauth#dailymotion'
  get "omni_session/connect"

  # for json request
  match '/capsuls_datas', to: 'capsuls#datas'

  # match '/:locale' => 'home#index'
  scope '(:locale)', constraints: { locale: /en|fr/ } do

    # all capsuls CRUD
    resources :capsuls

    #devise auth and sessions user
    devise_for :users, :path_names => { :sign_up => "register" }

    # any user profil exept current_user profil
    get "user/me"
    resources :user, :only => [:show]

    # root_path for /:locale
    root :to => 'home#index'
  end

end
