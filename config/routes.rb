Darts::Application.routes.draw do

  match 'uploaders', to: 'games#uploaders', as: 'uploaders'
  match 'uploader/:id', to: 'games#uploader', as: 'uploader'
  resources :darts, only: [:index,:new,:create]
  resources :players, only: [:index,:show] do
    resources :games, only: [:index]
  end
  resources :games, only: [:index]
  
  root :to => 'games#index'

end
