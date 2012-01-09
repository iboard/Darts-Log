Darts::Application.routes.draw do
  get "darts/index"

  
  resource :darts, only: [:index,:new,:create]

  
  root :to => 'darts#index'

end
