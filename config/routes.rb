Rails.application.routes.draw do


  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :comments
  resources :posts do
    resources :comments
  end

  resources :stats, only: [:index, :show]
  resources :profiles, only: [:show, :edit, :update]
  

  # Versioned API for Blog
  # You need to add /etc/hosts subdomain api
  # example:  
  # 192.168.31.234  ubuntu.blog
  # 192.168.31.234  api.ubuntu.blog
  
  namespace :api, path: '/', constraints: {subdomain: 'api'},  defaults: {format: :json} do | api |
    namespace :v1 do |v1|
      resources :posts, only: [:index, :create]
      resources :comments, only: [:index, :create]

      devise_scope :user do
        resources :sessions,        defaults: {format: :json}, only: [:create]
       end
    end
    namespace :v2 do |v2| 
      resources :posts, only: [:index, :create]
      resources :comments, only: [:index, :create]

      devise_scope :user do
        resources :sessions,        defaults: {format: :json}, only: [:create]
       end
    end
  end

  get 'home/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".


  # You can have the root of your site routed with "root"
  root to: "home#index"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
