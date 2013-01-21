Warehouse::Application.routes.draw do
  
  resources :sessions, only:[:create, :destroy]
  resources :users  
  resources :each_houses
  resources :main_lists
  resources :items
  resources :categories
	match '/doBackup', to: 'staticpages#doBackup'
	match '/deleteBackup', to: 'staticpages#deleteBackup'
	match '/restore', to: 'staticpages#restore'
	match '/backup', to: 'staticpages#backup'
	match '/statistic', to: 'staticpages#statistics'
  match '/dostatistic', to: 'staticpages#dostatistic'
  match '/operate', to: 'staticpages#operate'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'
  match '/newUser', to: 'users#newUser'
  match '/newAdmin', to: 'users#newAdmin'
  match '/out', to: 'staticpages#outhouse'
  match '/all', to: 'staticpages#allitem'
  match '/report', to: 'staticpages#report'
  match '/doreport', to: 'staticpages#doreport'
  match '/queryin', to: 'staticpages#queryin'
  match '/queryout', to: 'staticpages#queryout'
  match '/doqueryin', to: 'staticpages#doqueryin'
  match '/doqueryout', to: 'staticpages#doqueryout'
	match '/editinlist', to: 'staticpages#editinlist'
	match '/deleteinlist', to: 'staticpages#deleteinlist'
	match '/printinlist', to: 'staticpages#printinlist'
	match '/printoutlist', to: 'staticpages#printoutlist'
	match '/editoutlist', to: 'staticpages#editoutlist'
	match '/deleteoutlist', to: 'staticpages#deleteoutlist'
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
  root :to => 'staticpages#home'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.

end
