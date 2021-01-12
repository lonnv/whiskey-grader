Rails.application.routes.draw do
  root 'pages#main'
  resources :reviews, only: [:index, :new, :create]
end
