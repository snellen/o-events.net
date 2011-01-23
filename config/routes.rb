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

  controller :registration do
    get "registration/overview" => :overview
    get "registration/main" => :main
    get "registration/team_members" => :team_members
    get "registration/team_options" => :team_options
  end
  
  scope '(:locale)' do
    # put everything in here that should be localized

    controller :sessions do
      get 'login' => :new
      post 'login' => :create
      delete 'logout' => :destroy
    end
    
    controller :registration do
      get "registration/overview" => :overview
      get "registration/main" => :main
      get "registration/team_members" => :team_members
      get "registration/team_options" => :team_options
    end

    #must be on top:
    resources :languages
    resources :countries
    resources :users
    resources :clubs
    resources :currencies    
    #end    
    
    #should be on top because they may be filtered in different ways:
    resources :chips
    resources :start_blocks    
    resources :start_times
    resources :team_members
    resources :club_members
    
    resources :results do
      resources :split_times
    end
    
    resources :competitions do
      resources :team_registrations
      resources :total_results
      resources :runs
      
    end
    
    resources :competition_groups do
      resources :categories
      resources :category_groups
      resources :teams
    end
    
    resources :events do
      resources :age_ranges
      resources :additional_fees      
      resources :competitors
      resources :competing_clubs
      resources :country_groups
      resources :start_fees
      resources :registration_deadlines      
    end
    
    resources :payment_groups do
      resources :payments      
    end
    
    root :to => "events#index", :as => 'events_index'
  end

end
