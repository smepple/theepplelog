Theepplelog::Application.routes.draw do

  get "tags/index"

  get 'tags', to: 'tags#index', as: 'tags'
  get 'tags/:tag', to: 'posts#index', as: 'tag'
  post "versions/:id/revert", :to => "versions#revert", :as => "revert_version"
  match '/signin', :to => 'sessions#new'
  match '/signout', to: 'sessions#destroy', as: 'signout'
  match '/about', :to => 'static_pages#about'
  match '/admin', :to => 'posts#admin'
  # match '/new', :to => 'posts#new'
  match '/posts/:id/preview', :to => 'posts#preview', :as => 'preview'
  get '/posts', :to => 'posts#index'
  match '/archive', :to => 'posts#archive'
  match 'archive/:year/:month', :to => 'posts#archive', :as => 'archives'
  get '/:slug', :to => 'posts#show', :as => 'post'
  # get 'posts/:id', :to => 'posts#edit'
  # post '/sessions', :to => 'sessions#create'
  # post '/:id', :to => 'posts#create'
  put '/:id', :to => 'posts#update'
  delete '/:id', :to => 'posts#destroy'
  resources :posts
  resources :users
  resources :sessions

  root to: "posts#index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
