Darts::Application.routes.draw do

    
  resources :darts, only: [:index,:new,:create]
  resources :players, only: [:index,:show] do
    resources :games, only: [:index]
  end
  resources :games, only: [:index]  

  
  root :to => 'games#index'

end
