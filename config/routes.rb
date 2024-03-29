OTElections::Application.routes.draw do
  root :to => 'sessions#create'
  
  get "rush_vote/new", :as => :thanks

  get "rush_vote/select", :as => :rush_voting

  match "rush_vote/vote" => 'rush_vote#vote', :as => :rushvotes

  get "rush_vote/tally"
  
  match "rushes" => 'rushes#index', :as => :rushes

  resources :rushes
  
  #get 'rushes', 'rushes#index', :as => :rushes

   
  match "admin" => 'admin#index'

  match "admin/raw_results/:id" => 'admin#raw_results', :as => :raw_results

  match "admin/irv_calc/:id" => 'admin#irv_calc', :as => :runoff

  match "admin/poll_calc/:id" => 'admin#poll_calc', :as => :poll

  
  resources :elections
  resources :users
  
  match "elections/irv_vote" => 'elections#irv_vote'
  post "election/toggle_open_state" => 'elections#toggle_open_state'
  
  controller :sessions do
     get 'login' => :new
     post 'login' => :create
     delete 'logout' => :destroy
   end
   
   match 'rushes/delete/:id' => "rushes#destroy", :as => :del_rushes
   
   match "/openall" => "rushes#open_all", :as => :open_rushes
   match "/closeall" => 'rushes#close_all', :as => :close_rushes
   
   post "rush" => "rushes#toggle_open_state"
   
   post "vote" => "rushes#vote"
   
   match "admin/rush_index" => "admin#rush_index", :as => :rush_index
   
   match "admin/:id/results" => 'admin#rush_results', :as => :results
   
   match "admin/rush_results" => 'admin#all_rush_results', :as => :all_results

   match "admin/results/delete" => "admin#next_round", :as => :clear_round
   
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
  # match ':controller(/:action(/:id(.:format)))'
end
