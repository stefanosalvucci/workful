Rails.application.routes.draw do


  #yc_route
  get '/yc_fellowship', to: 'pages#dashboard'
  get '/dashboard', to: 'pages#dashboard'
  get '/catalogue', to: 'pages#catalogue'

  resources :invites, only: [:new, :index, :create, :destroy] do
    collection do
      get 'activation/:invite_code', to: 'invites#activation', as: :activation
      get 'share', to: 'invites#share_invite_url_frontoffice'
      post 'create_account'
      post 'wizard_invite_done'
      post 'request_demo'
    end
  end
  resources :companies, only: [:update] do
    collection do
      get 'configure'
    end
  end
  resources :carts, only: [:create, :destroy, :update]
  resources :item_subscriptions, path: 'subscriptions', only: [:index, :edit, :update, :destroy, :create] do
    collection do
      get 'create_subscriptions'
      get 'pre_checkout'
    end
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'pages/index'
  get 'pages/dashboard'
  get 'pages/catalogue'

  devise_for :users, path: 'account',
  path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup' },
  controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  resources :items
  resources :item_categories

  resource :users do
    get 'new_credit_card', as: :new_credit_card
    post 'save_credit_card'
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # authenticated do
  #   root 'pages#dashboard', as: :authenticated
  # end

  # You can have the root of your site routed with "root"
  root 'pages#landing'

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
