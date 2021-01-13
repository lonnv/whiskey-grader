# frozen_string_literal: true

Rails.application.routes.draw do
  root 'pages#main'
  resources :reviews, only: %i[index show new create]
end
