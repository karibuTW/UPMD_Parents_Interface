Rails.application.routes.draw do


  post 'helloasso/webhook'
  get 'locale/choose_locale'
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    devise_for :bus_drivers #, skip: [ :registrations ]
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
    namespace :parents do
      root to: 'profile#profile'
    end

    namespace :bus_drivers do
      root to: 'profile#profile'
      resources :children, only: [:show]
    end


    devise_for :parents, controllers: { registrations: 'parents/registrations', confirmations: 'parents/confirmations' }
    root to: 'static_pages#home'
  end
  require 'sidekiq/web'

  authenticate :admin_user, ->(user) { user.is_a? AdminUser } do
    mount Sidekiq::Web => '/sidekiq'
  end

end
