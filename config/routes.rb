Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "users" }
  
  devise_scope :user do
    put '/users/update_password', to: "users#update_password", as: :password_change
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # add a member action for contacting musicians
  # also there will be a nested resource of messages
  # that a musician can check
  resources :musicians do
    member do
      get 'contact'
      get 'messages'
      post 'upload'
      get 'songs'
      post 'song_upload', to: "songs#upload"
      post 'song_upload_thumb', to: "songs#upload_thumb"
    end
    resources :messages do
      member do
        get '/get_message', to: "messages#get_message"
        post '/create_reply', to: "replies#create_reply"
        get '/get_reply', to: "messages#get_reply"
        get '/last_created_reply', to: "messages#last_created_reply"
      end
    end
  end 

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
