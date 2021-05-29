Rails.application.routes.draw do
  namespace :parents do
    root to: 'profile#profile'
  end
  devise_for :parents
  root to: 'static_pages#home'
  
end
