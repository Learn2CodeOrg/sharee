Rails.application.routes.draw do

  devise_for :users

  resources :welcome
  resources :campaigns do
    get :payments, on: :member
    get :codes, on: :member
  end
  resources :links
  get 'roles/change'
  get 'sell_actions/set_approve'
  resources :commissions do
    get :pay, on: :collection
  end
  resources :billing_infos
  resources :thanks

  namespace :api do
    namespace :v1 do
      resources :links, only: :create
      resources :sell_actions, only: :create
    end
  end

  get 'about' => 'high_voltage/pages#show', id: 'about'
  get 'tos' => 'high_voltage/pages#show', id: 'tos'
  get 'faq' => 'high_voltage/pages#show', id: 'faq'
  get 'contact' => 'high_voltage/pages#show', id: 'contact'
  get 'merchant-info' => 'high_voltage/pages#show', id: 'merchant-info'

  get '*path', to: 'redirects#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
