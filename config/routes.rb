Treebook::Application.routes.draw do
  

 # opinio_model

  get "profiles/show"

  devise_for :users

  devise_scope :user do
    get 'register', to: 'devise/registrations#new', as: :register
    get 'login', to: 'devise/sessions#new', as: :login
    get 'logout', to: 'devise/sessions#destroy', as: :logout
  end

  resources :statuses
  get 'feed', to: 'statuses#index', as: :feed
  root to: 'statuses#index'

  resource :profile #, :only => :show, :as => :current_profile, :type => :current_profile
    get '/:id', to: 'profiles#show'
    #  match 'show/:id' => 'profiles#show'

  resources :likes
  match 'likes/:id', :controller => 'likes',  :action => 'show'

  resources :ratings, :only => [:create, :update, :destroy]
  
  resources :statuses
  match '/statuses/rate/:id', :controller => 'statuses', :action =>'rate'


  resources :follows
  match 'follows/:id', :controller => 'follows',  :action => 'show'
  # AJAX RATING
 # resources :rates do
  #  member do
  #  post :rate
 # end
# end

  
  # map.resources :statuses, :user => {:rate => :post}
  #resources :statuses do
   # opinio
  #end
  
   # get 'like'. to 'statuses#show'
  #####  match '/:id' => 'user#show'
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


