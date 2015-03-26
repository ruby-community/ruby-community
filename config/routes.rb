Rails.application.routes.draw do
  root 'welcomes#show'

  resource :welcomes
  resources :pages
end
