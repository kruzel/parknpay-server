ParknpayServer::Application.routes.draw do

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

  match '/api/v1/users/:user_id/cars/:id(.:format)', :controller => 'options', :action => 'options', :constraints => {:method => 'OPTIONS'}
 
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
  match '*not_found' => 'errors#handle404'
  
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
