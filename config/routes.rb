Rails.application.routes.draw do
  resources :invites, only: [:new, :index, :create, :destroy] do
    collection do
      get 'activation/:invite_code', to: 'invites#activation', as: :activation
      post 'create_account'
      post 'wizard_invite_done'
    end
  end
  resources :companies, only: [:update] do
    collection do
      get 'configure'
    end
  end
  resources :order_items, only: [:create, :destroy]
  resources :item_subscriptions, path: 'subscriptions', only: [:index, :edit, :update, :destroy] do
    collection do
      get 'create_subscriptions'
    end
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'pages/index'
  get 'pages/dashboard'

  devise_for :users, path: 'account',
  path_names: { sign_in: 'login', sign_out: 'logout', sign_up: 'signup' },
  controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }

  resources :items
  resources :item_categories
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  authenticated do
    root 'pages#dashboard', as: :authenticated
  end

  # You can have the root of your site routed with "root"
  root 'pages#dashboard'

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
