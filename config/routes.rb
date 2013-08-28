Verso::Application.routes.draw do

  devise_for :users, controllers: { sessions: "sessions", registrations: "registrations" }

  scope "/api" do
    scope "/v1"  do     
      resources :users do
        resources :cars do
          member do
            post :upload_image
          end
        end
      end

      resources :cities do
        collection do
          get :get_rates
        end
        resources :areas do
          resources :streets
          resources :rates
        end
      end

      resources :creditors

      resources :payments do
        collection do
          get :users_payments
        end
      end
    end
  end

  #chrome PUT support
  match '/api/v1/users/:id(.:format)', :controller => 'options', :action => 'options', :constraints => {:method => 'OPTIONS'}
  match '/api/v1/users/:user_id/cars/:id(.:format)', :controller => 'options', :action => 'options', :constraints => {:method => 'OPTIONS'}
  match '/api/v1/payments/:id(.:format)', :controller => 'options', :action => 'options', :constraints => {:method => 'OPTIONS'}


  # new routes
  resources :admin_pages, only: [] do
    collection do
      get 'sign_in'
      get 'dashboard'
      get 'tables'
      get 'elements'
      get 'media'
      get 'forms'
      get 'grid'
      get 'buttons'
      get 'notification'
      get 'calendar'
      get 'chat'
      get 'charts'
      get 'profile'
    end
  end

  resource :portfolio, only: [] do
    collection do
      get 'two_column'
      get 'three_column'
      get 'four_column'
      get 'single'
      get 'video'
      get 'alternative_slider'
    end
  end

  get 'pricing' => 'pricings#index'

  resources :pages, only: [] do
    collection do
      get 'about_us'
      get 'contact_us'
      get 'team'
      get 'features'
      get 'components'
      get 'sitemap'
      get 'error_404'
    end
  end

  resource :blog, only: [] do
    collection do
      get 'single'
      get 'category'
      get 'category_alternative'
      get 'pinterest'
    end
  end

  root to: 'pages#home'


  # old routes

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action
  
  match "/udashboard" => "u_dashboard#index"
  match "/udashboard/update" => "u_dashboard#update"
  match 'contact' => 'contact#new', :as => 'contact', :via => :get
  match 'contact' => 'contact#create', :as => 'contact', :via => :post
  match 'about' => 'about#index'

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
  root :to => 'home#index'

  mount_sextant if Rails.env.development?
  #match '*not_found' => 'errors#handle404'
  
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
