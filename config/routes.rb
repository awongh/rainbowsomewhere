Rainbowsomewhere::Application.routes.draw do

  root :to => 'pages#index'

  resources :find_rainbows do
    collection do
      get :find
    end
  end
end
