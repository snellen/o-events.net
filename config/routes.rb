OEventsNet::Application.routes.draw do

  resources :member_roles

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
    delete "registration/main" => :team_delete
    post "registration/main" => :team_save
    put "registration/main" => :team_save    
    get "registration/team_members" => :team_members
    post "registration/team_members" => :team_addmember
    delete "registration/team_members" => :team_removemember
    post "registration/search_user" => :search_user      
    get "registration/team_options" => :team_options
  end

  controller :post_finance do 
    get "post_finance/payment_accepted" => :payment_accepted
    get "post_finance/payment_declined" => :payment_declined
    get "post_finance/payment_canceled" => :payment_canceled
    get "post_finance/payment_exception" => :payment_exception
    get "post_finance/post_sale" => :post_sale
  end

  controller :ebanking do
    get "/ebanking/show/:bill" => :show, :as => 'show_ebanking'
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
      delete "registration/main" => :team_delete
      post "registration/main" => :team_save
      put "registration/main" => :team_save      
      get "registration/team_members" => :team_members
      post "registration/team_members" => :team_addmember
      delete "registration/team_members" => :team_removemember
      post "registration/search_user" => :search_user      
      get "registration/team_options" => :team_options
    end

    controller :post_finance do 
      get "post_finance/payment_accepted" => :payment_accepted
      get "post_finance/payment_declined" => :payment_declined
      get "post_finance/payment_canceled" => :payment_canceled
      get "post_finance/payment_exception" => :payment_exception
      get "post_finance/post_sale" => :post_sale
    end
    
    controller :ebanking do
      get "/ebanking/show/:bill" => :show, :as => 'show_ebanking'
    end
    
    #resource nesting is no longer used, it only complicates things

    resources :events
    match '/:year/:slug' => 'events#show', :constraints => { :year => /\d{4}/, :slug => /[a-z0-9]+/}
    resources :bills, :only => [:index, :show, :new, :create] do
        collection do 
          get 'unpaid_fees', :as => 'unpaid_fees'
        end
    end
    resources :users do
      member do
        get 'change_password', :as => 'change_password'
      end
    end
    match '/myaccount' => 'users#show', :as => 'myaccount'

    resources :teams
    resources :payments    
    
=begin    
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
    resources :country_groups
    resources :currencies
    resources :event_settings
    resources :languages
    resources :registration_deadlines      
    resources :results
    resources :runs
    resources :split_times
    resources :start_blocks    
    resources :start_fees
    resources :start_times
    resources :team_members
    resources :team_pools
    resources :team_registrations
    resources :total_results
    resources :payment_log_entries, :only => [:show, :index]
=end
    
    root :to => "events#index", :as => 'events_index'
  end

end
