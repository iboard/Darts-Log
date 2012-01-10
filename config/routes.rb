Darts::Application.routes.draw do

    
  get "player/index"

  resources :darts, only: [:index,:new,:create]
  resources :players, only: [:index,:show]
  resources :games, only: [:index]  

  
  root :to => 'darts#index'

end
