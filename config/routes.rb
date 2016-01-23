Rails.application.routes.draw do
  root to: redirect('pages/user_rules') #'welcomes#show'

  resource  :welcomes
  resources :pages
  resource  :faq
  resources :logs

  namespace :ruboto do
    resources :facts
    resources :commands
  end
end
