OEventsNet::Application.routes.draw do

  
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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
  
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  scope '(:locale)' do
    # put everything in here that should be localized

    resources :additional_fees
    resources :age_ranges
    resources :categories
    resources :category_groups
    resources :chips
    resources :club_members
    resources :clubs
    resources :competing_clubs
    resources :competition_groups
    resources :competitions
    resources :competitors
    resources :countries
    resources :events
    resources :languages
    resources :nations
    resources :nation_groups
    resources :payment_groups
    resources :payments
    resources :registration_deadlines
    resources :results
    resources :currencies
    resources :runs
    resources :split_times
    resources :start_blocks    
    resources :start_fees
    resources :start_times
    resources :team_members
    resources :teams
    resources :total_results
    resources :users do
      resources :events
      resources :clubs
    end
    
    root :to => "events#index", :as => 'events_index'
  end

end
